
from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.index, name='index'),
    #url(r'^incident_save/$', views.incident_save, name='incident_save'),
    url(r'^populate_incidents/$', views.populate_incidents, name='populate_incidents'),
    url(r'^fetch_districts/$', views.fetch_districts, name='fetch_districts'),
    url(r'^fetch_provinces/$', views.fetch_provinces, name='fetch_provinces'),
    url(r'^populate_verified_incidents/$', views.populate_verified_incidents, name='populate_verified_incidents'),
	
]
