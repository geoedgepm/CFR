import os
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse, JsonResponse
from django.db import IntegrityError, transaction
from django.core.serializers.json import DjangoJSONEncoder

from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
from django.conf import settings
import time
import datetime
import hashlib

from django.utils.translation import ugettext_lazy as _

from .forms import IncidentForm
from .models import Incident, Validation
from django.views.decorators.csrf import csrf_protect, csrf_exempt
from settings.models import DisasterType
from incidents.models import Incident, Photo, GarbledIncident, CloseEndQs, CloseEndQsChoice, IncidentUserChoices
from users.models import MyUser
import json
from django.views.generic.list import ListView
from django.core.paginator import Paginator
from django.core.paginator import EmptyPage
from django.core.paginator import PageNotAnInteger

from .models import IncidentLanguageTranslation
from django.utils import six
from django.core.exceptions import PermissionDenied
from django.contrib.auth.decorators import user_passes_test, login_required
from django.utils.decorators import method_decorator
from django.contrib.auth.decorators import login_required

from .tables import IncidentTable
from .filters import IncidentFilter
from django_tables2 import RequestConfig
from django_tables2 import SingleTableView
from binascii import a2b_base64
from base64 import decodestring
import datetime
import time
from django.core import serializers
from itertools import chain
from django.db.models import Count
from threading import Thread


from emails.views import sendmail, msgbodygrnaration


# user permission func
def permission_required(perm, login_url=None, raise_exception=True):
    def check_perms(user):
        if isinstance(perm, six.string_types):
            perms = (perm, )
        else:
            perms = perm
        if user.has_perms(perms):
            return True
        if raise_exception and user.pk:
            raise PermissionDenied
        return False
    return user_passes_test(check_perms, login_url=login_url)


# initial page load
def index(request, language):
    language_translation = IncidentLanguageTranslation.objects.filter(language=language)
    context = {'language_translations': language_translation[0],
               'language': language}
    return render(request, 'incidents/index.html', context)


# incident form load
def incident_form(request, language):

    language_filter = None
    lan = None

    if language == 'en':
        language_filter = 'english'
        lan = 'en'
    elif language == 'si':
        language_filter = 'sinhala'
        lan = 'si'
    elif language == 'ta':
        language_filter = 'tamil'
        lan = 'ta'

    disasters = DisasterType.objects.extra(
        select={'name': language_filter}) \
        .values('name', 'id').order_by('name')

    dropdown_select_msg = IncidentLanguageTranslation.objects.filter(language=lan)

    language_translation = IncidentLanguageTranslation.objects.filter(language=language)
    context = {'disasters': disasters,
               'language_translations': language_translation[0],
               'language': language,
               'dropdown_selector': (dropdown_select_msg[0])
               }
    return render(request, 'incidents/form.html', context)


# incident validation page load
def incident_details(request, id):
    incident = Incident.objects.get(id=id)
    user_choices = IncidentUserChoices.objects.filter(incident=incident).values('question_id').annotate(count=Count('question'))

    user_choice_list = []
    for qs in user_choices:
        choice = {}
        question_id = qs['question_id']
        question = CloseEndQs.objects.filter(id=question_id)
        choice['question'] = question[0].question
        field_type = question[0].field_type

        choice['field_type'] = field_type

        if field_type == 'text':
            choice['answers'] = IncidentUserChoices.objects.filter(incident=incident).filter(question_id=question_id).values('text_input')
        else:
            choice['answers'] = IncidentUserChoices.objects.filter(incident=incident).filter(question_id=question_id).values('choice__choice')

        user_choice_list.append(choice)

    context = {'incident': incident,
               'incident_id': id,
               'user_choices': user_choice_list}
    return render(request, 'incidents/incident.html', context)


def incident_details_test(request):
    incident = Incident.objects.get(id=184)
    user_choices = IncidentUserChoices.objects.filter(incident=incident).values('question__question').annotate(count=Count('question'))

    user_choice_list = []
    for qs in user_choices:
        choice = {}
        choice['question'] = qs
        choice['answers'] = IncidentUserChoices.objects.filter(incident=incident).values('choice__choice')

        user_choice_list.append(choice)

    context = {'incident': incident,
               'incident_id': id,
               'user_choices': json.dumps(list(user_choice_list))}
    return HttpResponse(json.dumps(list(context), cls=DjangoJSONEncoder), content_type='application/json')


def class_view_decorator(function_decorator):
    """Convert a function based decorator into a class based decorator usable
    on class based Views.

    Can't subclass the `View` as it breaks inheritance (super in particular),
    so we monkey-patch instead.
    """

    def simple_decorator(View):
        View.dispatch = method_decorator(function_decorator)(View.dispatch)
        return View

    return simple_decorator


# incident table load
class incident_list(SingleTableView):
    model = Incident
    paginate_by = 10
    template_name = "incidents/incident_main.html"
    table_class = IncidentTable
    queryset = None

    def get_context_data(self, **kwargs):
        user = self.request.user

        if user.is_superuser:
            self.queryset = Incident.objects.all().order_by('-id')
        elif user.district is None:
            self.queryset = None
        else:
            district = user.district
            self.queryset = Incident.objects.filter(district=district).order_by('-id')

        context = super(incident_list, self).get_context_data(**kwargs)
        filter = IncidentFilter(self.request.GET, queryset=self.queryset)

        table = IncidentTable(filter.qs)
        RequestConfig(self.request, ).configure(table)

        if user.district is None and user.is_superuser is False:
            table = None
        context['filter'] = filter
        context['table'] = table
        context['district'] = user.district

        return context


# file upload
def handle_uploaded_file(photoes, incident):

    for photo in photoes:
        time_now = int(round(time.time() * 1000))
        photo_name = "inc_"+str(time_now)+".png"
        fh = open("uploaded/"+photo_name, "wb")
        fh.write(str(photo.split(",")[1].decode('base64')))
        fh.close()
        photo_inst = Photo(name=photo_name)
        photo_inst.incident = incident
        photo_inst.save()


# saving close end questions
def save_close_end_qs(incident, qs_list):
    question_with_choices = []
    if qs_list:
        for choice in qs_list:
            if isinstance(qs_list[choice], dict):
                choices = qs_list[choice]
                question_with_choices.append(choices)
                question = CloseEndQs.objects.filter(field_name=choice)
                if question:
                    for multiple_choice in choices:
                        choice_id = multiple_choice
                        choice_result = choices[choice_id]
                        if choice_result:
                            if not (choice_result == 'No' and question.field_type == 'boolean'):
                                user_choice = IncidentUserChoices(incident=incident, choice_id=choice_id, question=question[0])
                                user_choice.save()
            else:
                choice_id = qs_list[choice]
                if choice_id:
                    question = CloseEndQs.objects.filter(field_name=choice)
                    if question:
                        if question[0].field_type == 'text':
                            user_choice = IncidentUserChoices(incident=incident, question=question[0], text_input=choice_id)
                            user_choice.save()
                        else:
                            user_choice = IncidentUserChoices(incident=incident, choice_id=choice_id, question=question[0])
                            user_choice.save()
    return HttpResponse(qs_list)


# save close end qs for mobile app
@csrf_exempt
def save_app_qs(request):

    question_with_choices = []
    post_data = json.loads(request.body)
    incident_id = post_data['incident']
    incident = Incident.objects.get(id=incident_id)
    qs_list = post_data['qs_list']
    if qs_list:
        for choice in qs_list:
            if isinstance(qs_list[choice], dict):
                choices = qs_list[choice]
                question_with_choices.append(choices)
                question = CloseEndQs.objects.filter(field_name=choice)
                if question:
                    for multiple_choice in choices:
                        choice_id = multiple_choice
                        choice_result = choices[choice_id]
                        if choice_result:
                            if not (choice_result == 'No' and question.field_type == 'boolean'):
                                user_choice = IncidentUserChoices(incident=incident, choice_id=choice_id, question=question[0])
                                user_choice.save()
            else:
                choice_id = qs_list[choice]
                if choice_id:
                    question = CloseEndQs.objects.filter(field_name=choice)
                    if question:
                        if question[0].field_type == 'text':
                            user_choice = IncidentUserChoices(incident=incident, question=question[0], text_input=choice_id)
                            user_choice.save()
                        else:
                            user_choice = IncidentUserChoices(incident=incident, choice_id=choice_id, question=question[0])
                            user_choice.save()
    return HttpResponse('ok')


# saving incidents
@csrf_exempt
def incident_save(request):
    post_data = json.loads(request.body)
    name = None
    contact = None
    description = None
    disaster = None
    photos = None
    latitude = None
    longitude = None
    province = None
    district = None
    address = None
    qs_list = None

    if 'name' in post_data:
        name = post_data['name']
    if 'contact' in post_data:
        contact = post_data['contact']
    if 'description' in post_data:
        description = post_data['description']
    if 'disaster_type' in post_data:
        disaster_type_id = post_data['disaster_type']
        disaster = DisasterType.objects.get(id=int(disaster_type_id))
    if 'latitude' in post_data:
        latitude = post_data['latitude']
        longitude = post_data['longitude']
    if 'province' in post_data:
        province = post_data['province']
    if 'district' in post_data:
        district = post_data['district']
    if 'address' in post_data:
        address = post_data['address']
    if 'close_end_qs' in post_data:
        qs_list = post_data['close_end_qs']

    incident = Incident(name=name, contact_no=contact, description=description, disaster_type=disaster,
                        reported_date=datetime.datetime.now(), latitude=latitude, longitude=longitude,
                        province=province, district=district, address=address, is_validated=False)

    try:
        incident.save()
        choices = save_close_end_qs(incident, qs_list)
        if 'files' in post_data:
            photos = post_data['files']
            handle_uploaded_file(photos, incident)

        verification_officers = MyUser.objects.filter(district__name=district).values_list('email', flat=True)
        admin_email = MyUser.objects.filter(is_superuser=True).values_list('email', flat=True).values_list('email',
                                                                                                           flat=True)

        verification_officers = verification_officers | admin_email

        body_params = {'disaster_type': disaster.english, 'reported_date': str(datetime.datetime.now()),
                       'address': address}
        send_email(verification_officers, body_params, 'incident_report')

        return HttpResponse(choices)
    except Exception as ex:
        return HttpResponse(ex)


# validating incidents
@csrf_exempt
def save_validation(request):
    post_data = json.loads(request.body)
    validated_latitude = None
    validated_longitude = None
    comment = None
    address = None

    if 'validated_latitude' in post_data:
        validated_latitude = post_data['validated_latitude']
    if 'validated_longitude' in post_data:
        validated_longitude = post_data['validated_longitude']
    if 'comment' in post_data:
        comment = post_data['comment']
    if 'address' in post_data:
        address = post_data['address']

    incident_id = post_data['incident_id']

    validation = Validation(validated_latitude=validated_latitude, validated_longitude=validated_longitude, status='success', comment=comment,
                            date=datetime.datetime.now(), address=address, user=request.user)

    incident = Incident.objects.get(pk=incident_id)
    incident.is_validated = True
    incident.save()
    validation.save()
    validation.incident_set.add(incident)

    # send email to admin
    admin = MyUser.objects.filter(is_superuser=True)
    admin_email = admin[0].email

    validated_user = request.user.first_name
    body_params = {'disaster_type': (incident.disaster_type.english),
                   'reported_date': str(incident.reported_date),
                   'user': str(validated_user),
                   'address': address
                   }
    response = send_email([admin_email], body_params, 'incident_validation')

    return HttpResponse(response)


# incident discard
@csrf_exempt
def discard_incident(request):
    post_data = json.loads(request.body)
    incident_id = post_data['incident_id']

    incident = Incident.objects.get(pk=incident_id)

    name = incident.name
    contact_no = incident.contact_no
    description = incident.description
    reported_date = incident.reported_date
    latitude = incident.latitude
    longitude = incident.longitude
    province = incident.province
    district = incident.district
    address = incident.address

    garbled_incident = GarbledIncident(name=name, contact_no=contact_no, description=description,
                                       reported_date=reported_date, latitude=latitude, longitude=longitude,
                                       province=province, district=district, address=address, deleted_date=datetime.datetime.now())

    garbled_incident.save()
    incident.delete()
    return HttpResponse(incident_id)


# loading user choices in incident admin page
@csrf_exempt
def select_questions(request):
    post_data = json.loads(request.body)
    disaster = post_data['disaster']
    language = None
    question_lang = 'question'
    choice_lang = 'choice'

    if 'language' in post_data:
        language = post_data['language']
        if language == 'en':
            question_lang = 'question'
            choice_lang = 'choice'
        else:
            question_lang = language
            choice_lang = language

    questions = CloseEndQs.objects.filter(disaster_type=disaster).extra(
        select={'model': 'field_name', 'type': 'field_type', 'label': question_lang}) \
        .values('id', 'model', 'type', 'label', 'disaster_type')

    question_with_choices = []
    for qs in questions:
        question = {}
        question['id'] = qs['id']
        question['model'] = qs['model']
        question['type'] = qs['type']
        question['label'] = qs['label']
        question['options'] = (list(CloseEndQsChoice.objects.
                                    filter(question_id=qs['id']).extra(select={'value': 'id', 'label': choice_lang}).
                                    values('value', 'label')))

        question_with_choices.append(question)

    return HttpResponse(json.dumps(list(question_with_choices)))


# email sending func
def send_email(users, body_params, email_type):
    email_body = msgbodygrnaration(body_params, email_type)
    subject = None
    if email_type == 'incident_validation':
        subject = 'Incident Verfication'
    elif email_type == 'incident_report':
        subject = 'Incident Report'
    else:
        subject = "CFR"
    params = {'receiver_email': users, 'email_body': email_body, 'email_type': email_type, 'subject': subject}

    t = Thread(target=sendmail, args=(params,))
    response = t.start()
    return HttpResponse(response)

@csrf_exempt
def send_mail_app(request):
    post_data = json.loads(request.body)
    district = None
    if 'district' in post_data:
    	district = post_data['district']
    body_params = post_data['body_params']
    email_type = post_data['email_type']

    admin_email = MyUser.objects.filter(is_superuser=True).values_list('email', flat=True).values_list('email', flat=True)

    users = None
    if email_type == 'incident_report':
        verification_officers = (MyUser.objects.filter(district__name=district, is_superuser=False).values_list('email', flat=True))
        users = verification_officers | admin_email
    else:
        users = admin_email

    response = send_email(users, body_params, email_type)

    return HttpResponse(response)



# file upload (Insteal on php file)
@csrf_exempt
def upload_image(request, *args, **kwargs):

    if request.method != 'POST':

        response = {'status': 0, 'link' : ""} 
        return JsonResponse(response)

    if request.method == 'POST' and request.FILES['file']:
        file = request.FILES['file']
        filename = request.FILES['file'].name

        ext = filename.split('.')[-1]

        dt = datetime.datetime.now()
        microtime = time.mktime(dt.timetuple()) + dt.microsecond / 1000000.0 
        microtime_str = str(microtime)
        mi_result = hashlib.sha1(microtime_str.encode())
        microtime_result = mi_result.hexdigest()

        newfilname = microtime_result+'.'+ext
        save_path = os.path.join(settings.MEDIA_ROOT, newfilname)
        path = default_storage.save(save_path, ContentFile(file.read()))
        link = "/uploaded/" + newfilname

        response = {'status': "true", 'link' : link}
        return JsonResponse(response)


# Image link
@csrf_exempt
def image_link(request, id, *args, **kwargs):

    # photo = Photo.objects.filter(incident_id=id).exists()

    photos = Photo.objects.filter(incident_id=id).order_by('-id')[:1]
    if len(photos) > 0:
        for photo in photos:
            photo_name = str(photo.name)

        photo_lnik = "/uploaded/" + photo_name
    else:
        photo_lnik = ''
    return HttpResponse(photo_lnik)   
        
    