--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

-- Started on 2016-09-22 14:35:16 IST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 263 (class 1259 OID 294780)
-- Name: close_end_qs_choices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE close_end_qs_choices (
    id integer NOT NULL,
    choice character varying(1000),
    question_id integer
);


ALTER TABLE close_end_qs_choices OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 294778)
-- Name: close_end_qs_choices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE close_end_qs_choices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE close_end_qs_choices_id_seq OWNER TO postgres;

--
-- TOC entry 3612 (class 0 OID 0)
-- Dependencies: 262
-- Name: close_end_qs_choices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE close_end_qs_choices_id_seq OWNED BY close_end_qs_choices.id;


--
-- TOC entry 3481 (class 2604 OID 294783)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY close_end_qs_choices ALTER COLUMN id SET DEFAULT nextval('close_end_qs_choices_id_seq'::regclass);


--
-- TOC entry 3607 (class 0 OID 294780)
-- Dependencies: 263
-- Data for Name: close_end_qs_choices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY close_end_qs_choices (id, choice, question_id) FROM stdin;
\.


--
-- TOC entry 3613 (class 0 OID 0)
-- Dependencies: 262
-- Name: close_end_qs_choices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('close_end_qs_choices_id_seq', 1, false);


--
-- TOC entry 3483 (class 2606 OID 294793)
-- Name: pkey_qs_choice; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY close_end_qs_choices
    ADD CONSTRAINT pkey_qs_choice PRIMARY KEY (id);


--
-- TOC entry 3484 (class 2606 OID 294787)
-- Name: fkey_disaster_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY close_end_qs_choices
    ADD CONSTRAINT fkey_disaster_type FOREIGN KEY (question_id) REFERENCES close_end_qs(id);


-- Completed on 2016-09-22 14:35:16 IST

--
-- PostgreSQL database dump complete
--

