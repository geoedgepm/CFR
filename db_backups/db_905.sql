PGDMP     &    9    
            t            cfr    9.5.4    9.5.4 ?    ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            ?           1262    181673    cfr    DATABASE     u   CREATE DATABASE cfr WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE cfr;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            ?           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    7            ?           0    0    public    ACL     ?   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    7                        3079    12393    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            ?           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1                        3079    181676    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                  false    7            ?           0    0    EXTENSION postgis    COMMENT     g   COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';
                       false    2            ?            1259    183083 
   auth_group    TABLE     ^   CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);
    DROP TABLE public.auth_group;
       public         riskinfo_lk    false    7            ?            1259    183081    auth_group_id_seq    SEQUENCE     s   CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.auth_group_id_seq;
       public       riskinfo_lk    false    7    204            ?           0    0    auth_group_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;
            public       riskinfo_lk    false    203            ?            1259    183093    auth_group_permissions    TABLE     ?   CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);
 *   DROP TABLE public.auth_group_permissions;
       public         riskinfo_lk    false    7            ?            1259    183091    auth_group_permissions_id_seq    SEQUENCE        CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.auth_group_permissions_id_seq;
       public       riskinfo_lk    false    206    7            ?           0    0    auth_group_permissions_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;
            public       riskinfo_lk    false    205            ?            1259    183073    auth_permission    TABLE     ?   CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);
 #   DROP TABLE public.auth_permission;
       public         riskinfo_lk    false    7            ?            1259    183071    auth_permission_id_seq    SEQUENCE     x   CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.auth_permission_id_seq;
       public       riskinfo_lk    false    7    202            ?           0    0    auth_permission_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;
            public       riskinfo_lk    false    201            ?            1259    183103 	   auth_user    TABLE     -  CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    province_id integer,
    district_id integer,
    ds_id integer,
    gn_id integer
);
    DROP TABLE public.auth_user;
       public         riskinfo_lk    false    7            ?            1259    183113    auth_user_groups    TABLE     x   CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);
 $   DROP TABLE public.auth_user_groups;
       public         riskinfo_lk    false    7            ?            1259    183111    auth_user_groups_id_seq    SEQUENCE     y   CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.auth_user_groups_id_seq;
       public       riskinfo_lk    false    7    210            ?           0    0    auth_user_groups_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;
            public       riskinfo_lk    false    209            ?            1259    183101    auth_user_id_seq    SEQUENCE     r   CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.auth_user_id_seq;
       public       riskinfo_lk    false    208    7            ?           0    0    auth_user_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;
            public       riskinfo_lk    false    207            ?            1259    183123    auth_user_user_permissions    TABLE     ?   CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);
 .   DROP TABLE public.auth_user_user_permissions;
       public         riskinfo_lk    false    7            ?            1259    183121 !   auth_user_user_permissions_id_seq    SEQUENCE     ?   CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.auth_user_user_permissions_id_seq;
       public       riskinfo_lk    false    7    212            ?           0    0 !   auth_user_user_permissions_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;
            public       riskinfo_lk    false    211            ?            1259    188347    disaster_type    TABLE     ?   CREATE TABLE disaster_type (
    id integer NOT NULL,
    english character varying(1000),
    sinhala character varying(1000),
    tamil character varying(1000)
);
 !   DROP TABLE public.disaster_type;
       public         riskinfo_lk    false    7            ?            1259    188345    disaster_type_id_seq    SEQUENCE     v   CREATE SEQUENCE disaster_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.disaster_type_id_seq;
       public       riskinfo_lk    false    7    229            ?           0    0    disaster_type_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE disaster_type_id_seq OWNED BY disaster_type.id;
            public       riskinfo_lk    false    228            ?            1259    188386    district    TABLE     m   CREATE TABLE district (
    id integer NOT NULL,
    name character varying(255),
    province_id integer
);
    DROP TABLE public.district;
       public         riskinfo_lk    false    7            ?            1259    188384    district_id_seq    SEQUENCE     q   CREATE SEQUENCE district_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.district_id_seq;
       public       riskinfo_lk    false    7    237            ?           0    0    district_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE district_id_seq OWNED BY district.id;
            public       riskinfo_lk    false    236            ?            1259    183177    django_admin_log    TABLE     ?  CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);
 $   DROP TABLE public.django_admin_log;
       public         riskinfo_lk    false    7            ?            1259    183175    django_admin_log_id_seq    SEQUENCE     y   CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.django_admin_log_id_seq;
       public       riskinfo_lk    false    7    214            ?           0    0    django_admin_log_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;
            public       riskinfo_lk    false    213            ?            1259    183063    django_content_type    TABLE     ?   CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);
 '   DROP TABLE public.django_content_type;
       public         riskinfo_lk    false    7            ?            1259    183061    django_content_type_id_seq    SEQUENCE     |   CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.django_content_type_id_seq;
       public       riskinfo_lk    false    200    7            ?           0    0    django_content_type_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;
            public       riskinfo_lk    false    199            ?            1259    183052    django_migrations    TABLE     ?   CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);
 %   DROP TABLE public.django_migrations;
       public         riskinfo_lk    false    7            ?            1259    183050    django_migrations_id_seq    SEQUENCE     z   CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.django_migrations_id_seq;
       public       riskinfo_lk    false    198    7            ?           0    0    django_migrations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;
            public       riskinfo_lk    false    197            ?            1259    183199    django_session    TABLE     ?   CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);
 "   DROP TABLE public.django_session;
       public         riskinfo_lk    false    7            ?            1259    188378    ds    TABLE     g   CREATE TABLE ds (
    id integer NOT NULL,
    name character varying(255),
    district_id integer
);
    DROP TABLE public.ds;
       public         riskinfo_lk    false    7            ?            1259    188376 	   ds_id_seq    SEQUENCE     k   CREATE SEQUENCE ds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.ds_id_seq;
       public       riskinfo_lk    false    7    235            ?           0    0 	   ds_id_seq    SEQUENCE OWNED BY     )   ALTER SEQUENCE ds_id_seq OWNED BY ds.id;
            public       riskinfo_lk    false    234            ?            1259    188370    gn    TABLE     a   CREATE TABLE gn (
    id integer NOT NULL,
    name character varying(255),
    ds_id integer
);
    DROP TABLE public.gn;
       public         riskinfo_lk    false    7            ?            1259    188368 	   gn_id_seq    SEQUENCE     k   CREATE SEQUENCE gn_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.gn_id_seq;
       public       riskinfo_lk    false    233    7            ?           0    0 	   gn_id_seq    SEQUENCE OWNED BY     )   ALTER SEQUENCE gn_id_seq OWNED BY gn.id;
            public       riskinfo_lk    false    232            ?            1259    188325    incident    TABLE     t  CREATE TABLE incident (
    id integer NOT NULL,
    name character varying(1000),
    latitude double precision,
    longitude double precision,
    disaster_type integer,
    contact_no character varying(12),
    address text,
    synced_date timestamp without time zone,
    reported_date timestamp without time zone,
    description text,
    validation_id integer
);
    DROP TABLE public.incident;
       public         riskinfo_lk    false    7            ?            1259    188323    incident_id_seq    SEQUENCE     q   CREATE SEQUENCE incident_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.incident_id_seq;
       public       riskinfo_lk    false    7    225            ?           0    0    incident_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE incident_id_seq OWNED BY incident.id;
            public       riskinfo_lk    false    224            ?            1259    188295    layer    TABLE     ?   CREATE TABLE layer (
    id integer NOT NULL,
    name character varying(1000),
    title character varying(1000),
    description text,
    date timestamp without time zone,
    user_id integer
);
    DROP TABLE public.layer;
       public         riskinfo_lk    false    7            ?            1259    188293    layer_id_seq    SEQUENCE     n   CREATE SEQUENCE layer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.layer_id_seq;
       public       riskinfo_lk    false    7    219            ?           0    0    layer_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE layer_id_seq OWNED BY layer.id;
            public       riskinfo_lk    false    218            ?            1259    183213    map    TABLE     ?   CREATE TABLE map (
    name character varying(1000),
    id integer NOT NULL,
    date timestamp without time zone,
    description text,
    user_id integer,
    title character varying(1000)
);
    DROP TABLE public.map;
       public         riskinfo_lk    false    7            ?            1259    188282 
   map_id_seq    SEQUENCE     l   CREATE SEQUENCE map_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.map_id_seq;
       public       riskinfo_lk    false    7    216            ?           0    0 
   map_id_seq    SEQUENCE OWNED BY     +   ALTER SEQUENCE map_id_seq OWNED BY map.id;
            public       riskinfo_lk    false    217            ?            1259    188306 	   map_layer    TABLE     ^   CREATE TABLE map_layer (
    id integer NOT NULL,
    map_id integer,
    layer_id integer
);
    DROP TABLE public.map_layer;
       public         riskinfo_lk    false    7            ?            1259    188304    map_layer_id_seq    SEQUENCE     r   CREATE SEQUENCE map_layer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.map_layer_id_seq;
       public       riskinfo_lk    false    221    7            ?           0    0    map_layer_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE map_layer_id_seq OWNED BY map_layer.id;
            public       riskinfo_lk    false    220            ?            1259    188336    photo    TABLE     k   CREATE TABLE photo (
    id integer NOT NULL,
    name character varying(1000),
    incident_id integer
);
    DROP TABLE public.photo;
       public         riskinfo_lk    false    7            ?            1259    188334    photo_id_seq    SEQUENCE     n   CREATE SEQUENCE photo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.photo_id_seq;
       public       riskinfo_lk    false    227    7            ?           0    0    photo_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE photo_id_seq OWNED BY photo.id;
            public       riskinfo_lk    false    226            ?            1259    188394    province    TABLE     T   CREATE TABLE province (
    id integer NOT NULL,
    name character varying(255)
);
    DROP TABLE public.province;
       public         riskinfo_lk    false    7            ?            1259    188392    province_id_seq    SEQUENCE     q   CREATE SEQUENCE province_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.province_id_seq;
       public       riskinfo_lk    false    7    239            ?           0    0    province_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE province_id_seq OWNED BY province.id;
            public       riskinfo_lk    false    238            ?            1259    196561    social_media_incident    TABLE     ?   CREATE TABLE social_media_incident (
    id integer NOT NULL,
    title character varying(255),
    description text,
    validation_id integer
);
 )   DROP TABLE public.social_media_incident;
       public         riskinfo_lk    false    7            ?            1259    196559    social_media_incident_id_seq    SEQUENCE     ~   CREATE SEQUENCE social_media_incident_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.social_media_incident_id_seq;
       public       riskinfo_lk    false    7    241            ?           0    0    social_media_incident_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE social_media_incident_id_seq OWNED BY social_media_incident.id;
            public       riskinfo_lk    false    240            ?            1259    188314    style    TABLE     ?   CREATE TABLE style (
    id integer NOT NULL,
    sld_title character varying(1000),
    name character varying(1000),
    date timestamp without time zone,
    url character varying(2000),
    layer_id integer
);
    DROP TABLE public.style;
       public         riskinfo_lk    false    7            ?            1259    188312    style_id_seq    SEQUENCE     n   CREATE SEQUENCE style_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.style_id_seq;
       public       riskinfo_lk    false    7    223            ?           0    0    style_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE style_id_seq OWNED BY style.id;
            public       riskinfo_lk    false    222            ?            1259    188358 
   validation    TABLE     ?   CREATE TABLE validation (
    id integer NOT NULL,
    status character varying(10),
    validated_latitude double precision,
    validated_longitude double precision,
    comment text,
    date timestamp without time zone,
    user_id integer
);
    DROP TABLE public.validation;
       public         riskinfo_lk    false    7            ?            1259    188356    validation_id_seq    SEQUENCE     s   CREATE SEQUENCE validation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.validation_id_seq;
       public       riskinfo_lk    false    7    231            ?           0    0    validation_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE validation_id_seq OWNED BY validation.id;
            public       riskinfo_lk    false    230            ?           2604    183086    id    DEFAULT     `   ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);
 <   ALTER TABLE public.auth_group ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    204    203    204            ?           2604    183096    id    DEFAULT     x   ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);
 H   ALTER TABLE public.auth_group_permissions ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    205    206    206            ?           2604    183076    id    DEFAULT     j   ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);
 A   ALTER TABLE public.auth_permission ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    201    202    202            ?           2604    183106    id    DEFAULT     ^   ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);
 ;   ALTER TABLE public.auth_user ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    208    207    208            ?           2604    183116    id    DEFAULT     l   ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);
 B   ALTER TABLE public.auth_user_groups ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    210    209    210            ?           2604    183126    id    DEFAULT     ?   ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);
 L   ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    212    211    212            ?           2604    188350    id    DEFAULT     f   ALTER TABLE ONLY disaster_type ALTER COLUMN id SET DEFAULT nextval('disaster_type_id_seq'::regclass);
 ?   ALTER TABLE public.disaster_type ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    229    228    229            ?           2604    188389    id    DEFAULT     \   ALTER TABLE ONLY district ALTER COLUMN id SET DEFAULT nextval('district_id_seq'::regclass);
 :   ALTER TABLE public.district ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    236    237    237            ?           2604    183180    id    DEFAULT     l   ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);
 B   ALTER TABLE public.django_admin_log ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    213    214    214            ?           2604    183066    id    DEFAULT     r   ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);
 E   ALTER TABLE public.django_content_type ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    200    199    200            ?           2604    183055    id    DEFAULT     n   ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);
 C   ALTER TABLE public.django_migrations ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    197    198    198            ?           2604    188381    id    DEFAULT     P   ALTER TABLE ONLY ds ALTER COLUMN id SET DEFAULT nextval('ds_id_seq'::regclass);
 4   ALTER TABLE public.ds ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    235    234    235            ?           2604    188373    id    DEFAULT     P   ALTER TABLE ONLY gn ALTER COLUMN id SET DEFAULT nextval('gn_id_seq'::regclass);
 4   ALTER TABLE public.gn ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    232    233    233            ?           2604    188328    id    DEFAULT     \   ALTER TABLE ONLY incident ALTER COLUMN id SET DEFAULT nextval('incident_id_seq'::regclass);
 :   ALTER TABLE public.incident ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    225    224    225            ?           2604    188298    id    DEFAULT     V   ALTER TABLE ONLY layer ALTER COLUMN id SET DEFAULT nextval('layer_id_seq'::regclass);
 7   ALTER TABLE public.layer ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    219    218    219            ?           2604    188284    id    DEFAULT     R   ALTER TABLE ONLY map ALTER COLUMN id SET DEFAULT nextval('map_id_seq'::regclass);
 5   ALTER TABLE public.map ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    217    216            ?           2604    188309    id    DEFAULT     ^   ALTER TABLE ONLY map_layer ALTER COLUMN id SET DEFAULT nextval('map_layer_id_seq'::regclass);
 ;   ALTER TABLE public.map_layer ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    221    220    221            ?           2604    188339    id    DEFAULT     V   ALTER TABLE ONLY photo ALTER COLUMN id SET DEFAULT nextval('photo_id_seq'::regclass);
 7   ALTER TABLE public.photo ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    227    226    227            ?           2604    188397    id    DEFAULT     \   ALTER TABLE ONLY province ALTER COLUMN id SET DEFAULT nextval('province_id_seq'::regclass);
 :   ALTER TABLE public.province ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    239    238    239            ?           2604    196564    id    DEFAULT     v   ALTER TABLE ONLY social_media_incident ALTER COLUMN id SET DEFAULT nextval('social_media_incident_id_seq'::regclass);
 G   ALTER TABLE public.social_media_incident ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    241    240    241            ?           2604    188317    id    DEFAULT     V   ALTER TABLE ONLY style ALTER COLUMN id SET DEFAULT nextval('style_id_seq'::regclass);
 7   ALTER TABLE public.style ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    223    222    223            ?           2604    188361    id    DEFAULT     `   ALTER TABLE ONLY validation ALTER COLUMN id SET DEFAULT nextval('validation_id_seq'::regclass);
 <   ALTER TABLE public.validation ALTER COLUMN id DROP DEFAULT;
       public       riskinfo_lk    false    231    230    231            ?          0    183083 
   auth_group 
   TABLE DATA               '   COPY auth_group (id, name) FROM stdin;
    public       riskinfo_lk    false    204   ??       ?           0    0    auth_group_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('auth_group_id_seq', 1, true);
            public       riskinfo_lk    false    203            ?          0    183093    auth_group_permissions 
   TABLE DATA               F   COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
    public       riskinfo_lk    false    206   ?       ?           0    0    auth_group_permissions_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);
            public       riskinfo_lk    false    205            ?          0    183073    auth_permission 
   TABLE DATA               G   COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
    public       riskinfo_lk    false    202   7?       ?           0    0    auth_permission_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('auth_permission_id_seq', 57, true);
            public       riskinfo_lk    false    201            ?          0    183103 	   auth_user 
   TABLE DATA               ?   COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, province_id, district_id, ds_id, gn_id) FROM stdin;
    public       riskinfo_lk    false    208   ??       ?          0    183113    auth_user_groups 
   TABLE DATA               :   COPY auth_user_groups (id, user_id, group_id) FROM stdin;
    public       riskinfo_lk    false    210   ??       ?           0    0    auth_user_groups_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);
            public       riskinfo_lk    false    209            ?           0    0    auth_user_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('auth_user_id_seq', 3, true);
            public       riskinfo_lk    false    207            ?          0    183123    auth_user_user_permissions 
   TABLE DATA               I   COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
    public       riskinfo_lk    false    212   ?       ?           0    0 !   auth_user_user_permissions_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 25, true);
            public       riskinfo_lk    false    211            ?          0    188347    disaster_type 
   TABLE DATA               =   COPY disaster_type (id, english, sinhala, tamil) FROM stdin;
    public       riskinfo_lk    false    229   V?       ?           0    0    disaster_type_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('disaster_type_id_seq', 1, true);
            public       riskinfo_lk    false    228            ?          0    188386    district 
   TABLE DATA               2   COPY district (id, name, province_id) FROM stdin;
    public       riskinfo_lk    false    237   ?       ?           0    0    district_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('district_id_seq', 2, true);
            public       riskinfo_lk    false    236            ?          0    183177    django_admin_log 
   TABLE DATA               ?   COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
    public       riskinfo_lk    false    214   ??       ?           0    0    django_admin_log_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('django_admin_log_id_seq', 27, true);
            public       riskinfo_lk    false    213            ?          0    183063    django_content_type 
   TABLE DATA               <   COPY django_content_type (id, app_label, model) FROM stdin;
    public       riskinfo_lk    false    200    ?       ?           0    0    django_content_type_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('django_content_type_id_seq', 20, true);
            public       riskinfo_lk    false    199            ?          0    183052    django_migrations 
   TABLE DATA               <   COPY django_migrations (id, app, name, applied) FROM stdin;
    public       riskinfo_lk    false    198   ?       ?           0    0    django_migrations_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('django_migrations_id_seq', 16, true);
            public       riskinfo_lk    false    197            ?          0    183199    django_session 
   TABLE DATA               I   COPY django_session (session_key, session_data, expire_date) FROM stdin;
    public       riskinfo_lk    false    215   w?       ?          0    188378    ds 
   TABLE DATA               ,   COPY ds (id, name, district_id) FROM stdin;
    public       riskinfo_lk    false    235   ?       ?           0    0 	   ds_id_seq    SEQUENCE SET     0   SELECT pg_catalog.setval('ds_id_seq', 1, true);
            public       riskinfo_lk    false    234            ?          0    188370    gn 
   TABLE DATA               &   COPY gn (id, name, ds_id) FROM stdin;
    public       riskinfo_lk    false    233         ?           0    0 	   gn_id_seq    SEQUENCE SET     0   SELECT pg_catalog.setval('gn_id_seq', 1, true);
            public       riskinfo_lk    false    232            ?          0    188325    incident 
   TABLE DATA               ?   COPY incident (id, name, latitude, longitude, disaster_type, contact_no, address, synced_date, reported_date, description, validation_id) FROM stdin;
    public       riskinfo_lk    false    225   8      ?           0    0    incident_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('incident_id_seq', 1, true);
            public       riskinfo_lk    false    224            ?          0    188295    layer 
   TABLE DATA               E   COPY layer (id, name, title, description, date, user_id) FROM stdin;
    public       riskinfo_lk    false    219   ?      ?           0    0    layer_id_seq    SEQUENCE SET     3   SELECT pg_catalog.setval('layer_id_seq', 1, true);
            public       riskinfo_lk    false    218            ?          0    183213    map 
   TABLE DATA               C   COPY map (name, id, date, description, user_id, title) FROM stdin;
    public       riskinfo_lk    false    216   ?      ?           0    0 
   map_id_seq    SEQUENCE SET     1   SELECT pg_catalog.setval('map_id_seq', 3, true);
            public       riskinfo_lk    false    217            ?          0    188306 	   map_layer 
   TABLE DATA               2   COPY map_layer (id, map_id, layer_id) FROM stdin;
    public       riskinfo_lk    false    221   1      ?           0    0    map_layer_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('map_layer_id_seq', 1, false);
            public       riskinfo_lk    false    220            ?          0    188336    photo 
   TABLE DATA               /   COPY photo (id, name, incident_id) FROM stdin;
    public       riskinfo_lk    false    227   N      ?           0    0    photo_id_seq    SEQUENCE SET     4   SELECT pg_catalog.setval('photo_id_seq', 1, false);
            public       riskinfo_lk    false    226            ?          0    188394    province 
   TABLE DATA               %   COPY province (id, name) FROM stdin;
    public       riskinfo_lk    false    239   k      ?           0    0    province_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('province_id_seq', 1, true);
            public       riskinfo_lk    false    238            ?          0    196561    social_media_incident 
   TABLE DATA               O   COPY social_media_incident (id, title, description, validation_id) FROM stdin;
    public       riskinfo_lk    false    241   ?      ?           0    0    social_media_incident_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('social_media_incident_id_seq', 1, true);
            public       riskinfo_lk    false    240            ?          0    181966    spatial_ref_sys 
   TABLE DATA               "   COPY spatial_ref_sys  FROM stdin;
    public       postgres    false    183   ?      ?          0    188314    style 
   TABLE DATA               B   COPY style (id, sld_title, name, date, url, layer_id) FROM stdin;
    public       riskinfo_lk    false    223   ?      ?           0    0    style_id_seq    SEQUENCE SET     4   SELECT pg_catalog.setval('style_id_seq', 1, false);
            public       riskinfo_lk    false    222            ?          0    188358 
   validation 
   TABLE DATA               j   COPY validation (id, status, validated_latitude, validated_longitude, comment, date, user_id) FROM stdin;
    public       riskinfo_lk    false    231         ?           0    0    validation_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('validation_id_seq', 1, false);
            public       riskinfo_lk    false    230            ?           2606    183090    auth_group_name_key 
   CONSTRAINT     R   ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_name_key;
       public         riskinfo_lk    false    204    204            ?           2606    183100 1   auth_group_permissions_group_id_permission_id_key 
   CONSTRAINT     ?   ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);
 r   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_permission_id_key;
       public         riskinfo_lk    false    206    206    206            ?           2606    183098    auth_group_permissions_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_pkey;
       public         riskinfo_lk    false    206    206            ?           2606    183088    auth_group_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_pkey;
       public         riskinfo_lk    false    204    204            ?           2606    183080 ,   auth_permission_content_type_id_codename_key 
   CONSTRAINT     ?   ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);
 f   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_codename_key;
       public         riskinfo_lk    false    202    202    202            ?           2606    183078    auth_permission_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_pkey;
       public         riskinfo_lk    false    202    202            ?           2606    183118    auth_user_groups_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_pkey;
       public         riskinfo_lk    false    210    210            ?           2606    183120 %   auth_user_groups_user_id_group_id_key 
   CONSTRAINT     w   ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);
 `   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_group_id_key;
       public         riskinfo_lk    false    210    210    210            ?           2606    183108    auth_user_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_pkey;
       public         riskinfo_lk    false    208    208            ?           2606    183128    auth_user_user_permissions_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_pkey;
       public         riskinfo_lk    false    212    212            ?           2606    183130 4   auth_user_user_permissions_user_id_permission_id_key 
   CONSTRAINT     ?   ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);
 y   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_permission_id_key;
       public         riskinfo_lk    false    212    212    212            ?           2606    183110    auth_user_username_key 
   CONSTRAINT     X   ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);
 J   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_username_key;
       public         riskinfo_lk    false    208    208            ?           2606    188355    disaster_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY disaster_type
    ADD CONSTRAINT disaster_pkey PRIMARY KEY (id);
 E   ALTER TABLE ONLY public.disaster_type DROP CONSTRAINT disaster_pkey;
       public         riskinfo_lk    false    229    229            ?           2606    188391    district_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY district
    ADD CONSTRAINT district_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.district DROP CONSTRAINT district_pkey;
       public         riskinfo_lk    false    237    237            ?           2606    183186    django_admin_log_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_pkey;
       public         riskinfo_lk    false    214    214            ?           2606    183070 3   django_content_type_app_label_45f3b1d93ec8c61c_uniq 
   CONSTRAINT     ?   ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_45f3b1d93ec8c61c_uniq UNIQUE (app_label, model);
 q   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_app_label_45f3b1d93ec8c61c_uniq;
       public         riskinfo_lk    false    200    200    200            ?           2606    183068    django_content_type_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_pkey;
       public         riskinfo_lk    false    200    200            ?           2606    183060    django_migrations_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
       public         riskinfo_lk    false    198    198            ?           2606    183206    django_session_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);
 L   ALTER TABLE ONLY public.django_session DROP CONSTRAINT django_session_pkey;
       public         riskinfo_lk    false    215    215            ?           2606    188383    ds_pkey 
   CONSTRAINT     A   ALTER TABLE ONLY ds
    ADD CONSTRAINT ds_pkey PRIMARY KEY (id);
 4   ALTER TABLE ONLY public.ds DROP CONSTRAINT ds_pkey;
       public         riskinfo_lk    false    235    235            ?           2606    188375    gn_pkey 
   CONSTRAINT     A   ALTER TABLE ONLY gn
    ADD CONSTRAINT gn_pkey PRIMARY KEY (id);
 4   ALTER TABLE ONLY public.gn DROP CONSTRAINT gn_pkey;
       public         riskinfo_lk    false    233    233            ?           2606    188333    incident_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY incident
    ADD CONSTRAINT incident_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.incident DROP CONSTRAINT incident_pkey;
       public         riskinfo_lk    false    225    225            ?           2606    188303 
   layer_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY layer
    ADD CONSTRAINT layer_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.layer DROP CONSTRAINT layer_pkey;
       public         riskinfo_lk    false    219    219            ?           2606    188311    map_layer_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY map_layer
    ADD CONSTRAINT map_layer_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.map_layer DROP CONSTRAINT map_layer_pkey;
       public         riskinfo_lk    false    221    221            ?           2606    188292    map_pkey 
   CONSTRAINT     C   ALTER TABLE ONLY map
    ADD CONSTRAINT map_pkey PRIMARY KEY (id);
 6   ALTER TABLE ONLY public.map DROP CONSTRAINT map_pkey;
       public         riskinfo_lk    false    216    216            ?           2606    188344 
   photo_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.photo DROP CONSTRAINT photo_pkey;
       public         riskinfo_lk    false    227    227            ?           2606    196569    pkey_id 
   CONSTRAINT     T   ALTER TABLE ONLY social_media_incident
    ADD CONSTRAINT pkey_id PRIMARY KEY (id);
 G   ALTER TABLE ONLY public.social_media_incident DROP CONSTRAINT pkey_id;
       public         riskinfo_lk    false    241    241            ?           2606    188399    province_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY province
    ADD CONSTRAINT province_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.province DROP CONSTRAINT province_pkey;
       public         riskinfo_lk    false    239    239            ?           2606    188322 
   style_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY style
    ADD CONSTRAINT style_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.style DROP CONSTRAINT style_pkey;
       public         riskinfo_lk    false    223    223            ?           2606    188366    validation_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY validation
    ADD CONSTRAINT validation_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.validation DROP CONSTRAINT validation_pkey;
       public         riskinfo_lk    false    231    231            ?           1259    183137 %   auth_group_name_253ae2a6331666e8_like    INDEX     i   CREATE INDEX auth_group_name_253ae2a6331666e8_like ON auth_group USING btree (name varchar_pattern_ops);
 9   DROP INDEX public.auth_group_name_253ae2a6331666e8_like;
       public         riskinfo_lk    false    204            ?           1259    183148    auth_group_permissions_0e939a4f    INDEX     _   CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);
 3   DROP INDEX public.auth_group_permissions_0e939a4f;
       public         riskinfo_lk    false    206            ?           1259    183149    auth_group_permissions_8373b171    INDEX     d   CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);
 3   DROP INDEX public.auth_group_permissions_8373b171;
       public         riskinfo_lk    false    206            ?           1259    183136    auth_permission_417f1b1c    INDEX     X   CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);
 ,   DROP INDEX public.auth_permission_417f1b1c;
       public         riskinfo_lk    false    202            ?           1259    183162    auth_user_groups_0e939a4f    INDEX     S   CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);
 -   DROP INDEX public.auth_user_groups_0e939a4f;
       public         riskinfo_lk    false    210            ?           1259    183161    auth_user_groups_e8701ad4    INDEX     R   CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);
 -   DROP INDEX public.auth_user_groups_e8701ad4;
       public         riskinfo_lk    false    210            ?           1259    183174 #   auth_user_user_permissions_8373b171    INDEX     l   CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);
 7   DROP INDEX public.auth_user_user_permissions_8373b171;
       public         riskinfo_lk    false    212            ?           1259    183173 #   auth_user_user_permissions_e8701ad4    INDEX     f   CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);
 7   DROP INDEX public.auth_user_user_permissions_e8701ad4;
       public         riskinfo_lk    false    212            ?           1259    183150 (   auth_user_username_51b3b110094b8aae_like    INDEX     o   CREATE INDEX auth_user_username_51b3b110094b8aae_like ON auth_user USING btree (username varchar_pattern_ops);
 <   DROP INDEX public.auth_user_username_51b3b110094b8aae_like;
       public         riskinfo_lk    false    208            ?           1259    183197    django_admin_log_417f1b1c    INDEX     Z   CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);
 -   DROP INDEX public.django_admin_log_417f1b1c;
       public         riskinfo_lk    false    214            ?           1259    183198    django_admin_log_e8701ad4    INDEX     R   CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);
 -   DROP INDEX public.django_admin_log_e8701ad4;
       public         riskinfo_lk    false    214            ?           1259    183207    django_session_de54fa62    INDEX     R   CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);
 +   DROP INDEX public.django_session_de54fa62;
       public         riskinfo_lk    false    215            ?           1259    183208 0   django_session_session_key_461cfeaa630ca218_like    INDEX        CREATE INDEX django_session_session_key_461cfeaa630ca218_like ON django_session USING btree (session_key varchar_pattern_ops);
 D   DROP INDEX public.django_session_session_key_461cfeaa630ca218_like;
       public         riskinfo_lk    false    215            ?           2606    183131 ?   auth_content_type_id_508cf46651277a81_fk_django_content_type_id    FK CONSTRAINT     ?   ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_content_type_id_508cf46651277a81_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 y   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_content_type_id_508cf46651277a81_fk_django_content_type_id;
       public       riskinfo_lk    false    200    202    3497            ?           2606    183138 ?   auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id    FK CONSTRAINT     ?   ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 ?   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id;
       public       riskinfo_lk    false    204    206    3507            ?           2606    183143 ?   auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id    FK CONSTRAINT     ?   ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 ?   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id;
       public       riskinfo_lk    false    202    3502    206            ?           2606    183168 ?   auth_user__permission_id_384b62483d7071f0_fk_auth_permission_id    FK CONSTRAINT     ?   ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user__permission_id_384b62483d7071f0_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 ?   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user__permission_id_384b62483d7071f0_fk_auth_permission_id;
       public       riskinfo_lk    false    3502    202    212            ?           2606    183156 ;   auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id    FK CONSTRAINT     ?   ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 v   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id;
       public       riskinfo_lk    false    210    3507    204            ?           2606    183151 9   auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id    FK CONSTRAINT     ?   ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 t   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id;
       public       riskinfo_lk    false    210    208    3515            ?           2606    183163 ?   auth_user_user_permiss_user_id_7f0938558328534a_fk_auth_user_id    FK CONSTRAINT     ?   ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permiss_user_id_7f0938558328534a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 ?   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permiss_user_id_7f0938558328534a_fk_auth_user_id;
       public       riskinfo_lk    false    3515    212    208            ?           2606    183187 ?   djan_content_type_id_697914295151027a_fk_django_content_type_id    FK CONSTRAINT     ?   ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT djan_content_type_id_697914295151027a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT djan_content_type_id_697914295151027a_fk_django_content_type_id;
       public       riskinfo_lk    false    214    200    3497            ?           2606    183192 9   django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id    FK CONSTRAINT     ?   ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 t   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id;
       public       riskinfo_lk    false    208    214    3515                       2606    196534    fk_district_ds    FK CONSTRAINT     i   ALTER TABLE ONLY ds
    ADD CONSTRAINT fk_district_ds FOREIGN KEY (district_id) REFERENCES district(id);
 ;   ALTER TABLE ONLY public.ds DROP CONSTRAINT fk_district_ds;
       public       riskinfo_lk    false    235    237    3560            ?           2606    196544    fk_district_user    FK CONSTRAINT     r   ALTER TABLE ONLY auth_user
    ADD CONSTRAINT fk_district_user FOREIGN KEY (district_id) REFERENCES district(id);
 D   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT fk_district_user;
       public       riskinfo_lk    false    208    3560    237                       2606    196524    fk_ds_gn    FK CONSTRAINT     W   ALTER TABLE ONLY gn
    ADD CONSTRAINT fk_ds_gn FOREIGN KEY (ds_id) REFERENCES ds(id);
 5   ALTER TABLE ONLY public.gn DROP CONSTRAINT fk_ds_gn;
       public       riskinfo_lk    false    3558    233    235            ?           2606    196549 
   fk_ds_user    FK CONSTRAINT     `   ALTER TABLE ONLY auth_user
    ADD CONSTRAINT fk_ds_user FOREIGN KEY (ds_id) REFERENCES ds(id);
 >   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT fk_ds_user;
       public       riskinfo_lk    false    3558    208    235            ?           2606    196554 
   fk_gn_user    FK CONSTRAINT     `   ALTER TABLE ONLY auth_user
    ADD CONSTRAINT fk_gn_user FOREIGN KEY (gn_id) REFERENCES gn(id);
 >   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT fk_gn_user;
       public       riskinfo_lk    false    208    233    3556            ?           2606    196489    fk_incident_disaster_type    FK CONSTRAINT     ?   ALTER TABLE ONLY incident
    ADD CONSTRAINT fk_incident_disaster_type FOREIGN KEY (disaster_type) REFERENCES disaster_type(id);
 L   ALTER TABLE ONLY public.incident DROP CONSTRAINT fk_incident_disaster_type;
       public       riskinfo_lk    false    3552    229    225                       2606    196494    fk_incident_photo    FK CONSTRAINT     o   ALTER TABLE ONLY photo
    ADD CONSTRAINT fk_incident_photo FOREIGN KEY (incident_id) REFERENCES incident(id);
 A   ALTER TABLE ONLY public.photo DROP CONSTRAINT fk_incident_photo;
       public       riskinfo_lk    false    3548    227    225            ?           2606    196479    fk_layer_map_layer    FK CONSTRAINT     n   ALTER TABLE ONLY map_layer
    ADD CONSTRAINT fk_layer_map_layer FOREIGN KEY (layer_id) REFERENCES layer(id);
 F   ALTER TABLE ONLY public.map_layer DROP CONSTRAINT fk_layer_map_layer;
       public       riskinfo_lk    false    221    3542    219            ?           2606    196484    fk_layer_style    FK CONSTRAINT     f   ALTER TABLE ONLY style
    ADD CONSTRAINT fk_layer_style FOREIGN KEY (layer_id) REFERENCES layer(id);
 >   ALTER TABLE ONLY public.style DROP CONSTRAINT fk_layer_style;
       public       riskinfo_lk    false    223    219    3542            ?           2606    196474    fk_map_map_layer    FK CONSTRAINT     h   ALTER TABLE ONLY map_layer
    ADD CONSTRAINT fk_map_map_layer FOREIGN KEY (map_id) REFERENCES map(id);
 D   ALTER TABLE ONLY public.map_layer DROP CONSTRAINT fk_map_map_layer;
       public       riskinfo_lk    false    3540    216    221                       2606    205064    fk_province_district    FK CONSTRAINT     u   ALTER TABLE ONLY district
    ADD CONSTRAINT fk_province_district FOREIGN KEY (province_id) REFERENCES province(id);
 G   ALTER TABLE ONLY public.district DROP CONSTRAINT fk_province_district;
       public       riskinfo_lk    false    3562    239    237            ?           2606    196539    fk_province_user    FK CONSTRAINT     r   ALTER TABLE ONLY auth_user
    ADD CONSTRAINT fk_province_user FOREIGN KEY (province_id) REFERENCES province(id);
 D   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT fk_province_user;
       public       riskinfo_lk    false    3562    208    239            ?           2606    196514    fk_user_layer    FK CONSTRAINT     h   ALTER TABLE ONLY layer
    ADD CONSTRAINT fk_user_layer FOREIGN KEY (user_id) REFERENCES auth_user(id);
 =   ALTER TABLE ONLY public.layer DROP CONSTRAINT fk_user_layer;
       public       riskinfo_lk    false    219    3515    208            ?           2606    196509    fk_user_map    FK CONSTRAINT     d   ALTER TABLE ONLY map
    ADD CONSTRAINT fk_user_map FOREIGN KEY (user_id) REFERENCES auth_user(id);
 9   ALTER TABLE ONLY public.map DROP CONSTRAINT fk_user_map;
       public       riskinfo_lk    false    208    216    3515                       2606    196504    fk_user_validation    FK CONSTRAINT     r   ALTER TABLE ONLY validation
    ADD CONSTRAINT fk_user_validation FOREIGN KEY (user_id) REFERENCES auth_user(id);
 G   ALTER TABLE ONLY public.validation DROP CONSTRAINT fk_user_validation;
       public       riskinfo_lk    false    231    208    3515                        2606    196575    fk_validation_incident    FK CONSTRAINT     {   ALTER TABLE ONLY incident
    ADD CONSTRAINT fk_validation_incident FOREIGN KEY (validation_id) REFERENCES validation(id);
 I   ALTER TABLE ONLY public.incident DROP CONSTRAINT fk_validation_incident;
       public       riskinfo_lk    false    225    3554    231                       2606    196570 #   fk_validation_social_media_incident    FK CONSTRAINT     ?   ALTER TABLE ONLY social_media_incident
    ADD CONSTRAINT fk_validation_social_media_incident FOREIGN KEY (validation_id) REFERENCES validation(id);
 c   ALTER TABLE ONLY public.social_media_incident DROP CONSTRAINT fk_validation_social_media_incident;
       public       riskinfo_lk    false    231    3554    241            ?      x?3?̭?O/?/-?????? *?_      ?      x?????? ? ?      ?   T  x?u?[n?0???U??j?e.??F?#4DS$?J??|?mھ??ÿ?ɟ??۱h???G?my??R?/????g;>??pI?
?.q? .	Xg?9.?~]?it%?ʂo??IX?g-mX?V?%????kvó?jMN?7??? NY?k???????C??)K?(uy?:U.~??-?g??????}ŇZk`?4|??<?`?s?d???gh?".?aH;cW?+If??????. ??|y?2?#	H]?Tҥ.[?+my??!?eu?N??r??*???=`nx?0y6???|????F?5D?2??5D?6F????1???:??0??A&d??v??v?'?sd?W?I,J??6vbi?״xJ???.??.????W?Q4F?B??$))n2N????>??2~??/d??d?}?Z,e??};????ꌎ$!?;?????:O??
Ɣ?????oĵ?~m?-.?,͗?Xjc\?xjԾb???+ԙ}E?k^???jB?E9??q0??3iLL?<?L??VlKO?w?]??7??dL>??p??L?7)F׭.?߭?1ކ)VIYcg???)+?H?o?G???ya?/є5??Y?@G?????T?0      ?   E  x?m??N?@?kx?^pg?{??%1JOkD?Vc??@)t+Kk?????Fk?L?dn?d?A?6~KR?Z?"??fgz$=??&????c1?s?9y?C????6?#Nkڋ\?T?5L?e< 7?t??E???5iW@?0?R??9/??L*U?M?ۜ{?ȸ?????1,?;E/׼????b.?1|?[U?Nd???Y??g;cڗ>Z??P'?g抋(?1??L?????}????h???8n?`???M????v??}??C?dA?V??t?ä]?;Xz?R?5???(?h??}?????b#??qbK?-??Ġl??UY?? ????      ?      x?????? ? ?      ?   9   x?ɱ?0???	??{??:??V]????h??VXh??? a?G=Yw?|?M?	H      ?      x?3?t)?/M?(???????? )M?      ?      x?3?t????M?4?????? #(?      ?   i  x????n?0E??Wh_??9|m?-??eC???,?R?_?=%]t??9?^? Cꎛ;9G?1\ |??? {(?y??????#??p?I?ёa`?4???`"ńά?\?+???&#&$-a?=6??/?m?o?E?+??,?Q?r? :?Ls?$ѽ?|?cm?"?$2???J?>^??/]ٮ?e{?]盺cg?^pi??"?V-?&uH???V*?~]5;__,6?? bF???l?E5?k???0&e?5	?D&y?AH?}???u???W?G?$??V!<?ֻ?y9?6D&V0fP@?C?$?ct?}&V??O?r? ??25(??9???_of0E?X(G??P????[???4??Z?????Z??vB0˹?o?7ؤ?q"??
?HwӢ9?r6NKH0 ??#?	???'??N?ښ?}?7~[ֳ&c*?T<?P?C? ??l|Q=?[_,?Ta*?N?i?????E?m??r???Uɮ?4xd׌,???V??l<???<p???Os??:??CqL??E}y???????#&&??z?Tx0?}????i??z:??o?qa/]?Ϧ??kӨ???Tς??\?;n??pmYt?_?/?Z???"?      ?   ?   x?}Pˎ? <?S????Y????Z"??)_?ȥ{{??gp@~?!?,?Mv??eUIJ?2[3)<A??U?-?u???W??
????>?@????ݾ??B&3_?????Jo???C????<Dt???L??J??ը;??^|5??
???Z.i???z?P5?Bad/?Q?D~?}W[BU?lf
????U?~??[??;D????:      ?   f  x????n? E??+??b??2?[*!???Ʈ?Q??%??"?m?a????? 9!???mt?  |??#PA)=?l?j9?%Æ?7-??;????BP??#????ŸF?R?WNj&?Wg?s?1??nߦ@#]m???v?MftS?c?CX??_?sᒿڵi???d??U6?|?????G??͖?)"?(?K?aLq???T??GKgc2?p?y???o\s\?]<27?9??T??soo_#(-qHtK?/l??
??Hz;?E???eX+.?*?џ??1M6??g?????@?e??&?8?
@F|8?s?)?jh?jpC9???M/pH??22ͫ3.?}L c????????@	?^WU?1??      ?   g  x????n?0?u?ݏ?'iiPb?("ؚ?M???N??'??ռB???:??+[??}yvK?6???zh=>????;?m?O?6?ri+?K? j??A?CY???Q??2?bFVN??????ݩ?????h?h2??K`ɲX??%?EeX?,?52VHB?t???????!?D֛??]?ң*rd"?K??IkE.????̦?qѠ	C?;??e?k?????~?q~޺??J???<??%פC????Ȼ?4X??-?L0.???u`??#???^ѩ{_T??O?|_|<@(`t?|*??{?y?+?fQ???N?t????{???=???????~????f???5o      ?      x?3?t	6?4?????? {?      ?      x?3?t?3?4?????? c?      ?   D   x?3????M???44?4?4?4077321512??4204?5??56T0??2??26?"f???????? U#?      ?   <   x?3??N?)-?H,J?O???O??????|N#C3]]cCK+#K+3N#?=... t?      ?   I   x?˭T?M,?4?????4??s?R2??KR??R?9?9??t,t?M?̭??@?Q?q??qqq ???      ?      x?????? ? ?      ?      x?????? ? ?      ?      x?3?O-.I-??????? #'?      ?   '   x?3?t?,N,.I-RH,Q??/?M?I?????????? ???      ?      x?????? ? ?      ?      x?????? ? ?      ?      x?????? ? ?     