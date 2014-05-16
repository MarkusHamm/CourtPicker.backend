--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: Roger; Type: SCHEMA; Schema: -; Owner: roger
--

CREATE SCHEMA "Roger";


ALTER SCHEMA "Roger" OWNER TO roger;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

--CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

--COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: saison_sequence; Type: SEQUENCE; Schema: public; Owner: roger
--

CREATE SEQUENCE saison_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.saison_sequence OWNER TO roger;

SET search_path = "Roger", pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Abo; Type: TABLE; Schema: Roger; Owner: roger; Tablespace: 
--

CREATE TABLE "Abo" (
    "SaisonId" integer DEFAULT nextval('public.saison_sequence'::regclass) NOT NULL,
    "AboBeginn" date NOT NULL,
    "AboEnde" date NOT NULL,
    "AboName" character varying(90) NOT NULL,
    "Bookable" smallint NOT NULL,
    "AboPreisMitglied" integer,
    "AboPreisNichtMitglied" integer,
    "ZeitVon" time without time zone,
    "ZeitBis" time without time zone
);


ALTER TABLE "Roger"."Abo" OWNER TO roger;

SET search_path = public, pg_catalog;

--
-- Name: authorities_sequence; Type: SEQUENCE; Schema: public; Owner: roger
--

CREATE SEQUENCE authorities_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorities_sequence OWNER TO roger;

SET search_path = "Roger", pg_catalog;

--
-- Name: Authorities; Type: TABLE; Schema: Roger; Owner: postgres; Tablespace: 
--

CREATE TABLE "Authorities" (
    "Customer_Username" character varying(45) NOT NULL,
    authority character varying(45),
    "ID" integer DEFAULT nextval('public.authorities_sequence'::regclass) NOT NULL,
    "Customer_CustomerID" integer NOT NULL
);


ALTER TABLE "Roger"."Authorities" OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- Name: court_sequence; Type: SEQUENCE; Schema: public; Owner: roger
--

CREATE SEQUENCE court_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.court_sequence OWNER TO roger;

SET search_path = "Roger", pg_catalog;

--
-- Name: Court; Type: TABLE; Schema: Roger; Owner: roger; Tablespace: 
--

CREATE TABLE "Court" (
    "CourtID" integer DEFAULT nextval('public.court_sequence'::regclass) NOT NULL,
    "CourtNumber" integer NOT NULL,
    "CourtName" character varying(45),
    "IndoorCourt" integer NOT NULL,
    "Bookable" integer NOT NULL
);


ALTER TABLE "Roger"."Court" OWNER TO roger;

SET search_path = public, pg_catalog;

--
-- Name: customer_sequence; Type: SEQUENCE; Schema: public; Owner: roger
--

CREATE SEQUENCE customer_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_sequence OWNER TO roger;

SET search_path = "Roger", pg_catalog;

--
-- Name: Customer; Type: TABLE; Schema: Roger; Owner: roger; Tablespace: 
--

CREATE TABLE "Customer" (
    "CustomerID" integer DEFAULT nextval('public.customer_sequence'::regclass) NOT NULL,
    "FirstName" character varying(30),
    "LastName" character varying(45),
    "Email" character varying(60),
    "Username" character varying(45),
    "Password" character varying,
    "Enabled" boolean NOT NULL,
    "isMember" boolean NOT NULL,
    "Code" character varying(45),
    "Street" character varying(45),
    "PLZ" character varying(45),
    "City" character varying(45),
    "Country" character varying(45),
    "Birthday" date,
    "Handy" character varying(45),
    "Telefon" character varying(45)
);


ALTER TABLE "Roger"."Customer" OWNER TO roger;

SET search_path = public, pg_catalog;

--
-- Name: invoice_sequence; Type: SEQUENCE; Schema: public; Owner: roger
--

CREATE SEQUENCE invoice_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invoice_sequence OWNER TO roger;

SET search_path = "Roger", pg_catalog;

--
-- Name: Invoice; Type: TABLE; Schema: Roger; Owner: roger; Tablespace: 
--

CREATE TABLE "Invoice" (
    "idInvoice" integer DEFAULT nextval('public.invoice_sequence'::regclass) NOT NULL,
    "InvoiceDate" timestamp without time zone,
    "Customer_CustomerID" integer NOT NULL,
    "TotalPrice" integer,
    "aboCount" integer,
    "singleCount" integer,
    "Bezahlt" character varying(45)
);


ALTER TABLE "Roger"."Invoice" OWNER TO roger;

--
-- Name: Members; Type: TABLE; Schema: Roger; Owner: roger; Tablespace: 
--

CREATE TABLE "Members" (
    "Vorname" character varying,
    "Titel" character varying,
    "MemberID" character varying NOT NULL
);


ALTER TABLE "Roger"."Members" OWNER TO roger;

SET search_path = public, pg_catalog;

--
-- Name: reservation_sequence; Type: SEQUENCE; Schema: public; Owner: roger
--

CREATE SEQUENCE reservation_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservation_sequence OWNER TO roger;

SET search_path = "Roger", pg_catalog;

--
-- Name: Reservation; Type: TABLE; Schema: Roger; Owner: roger; Tablespace: 
--

CREATE TABLE "Reservation" (
    "ReservationID" integer DEFAULT nextval('public.reservation_sequence'::regclass) NOT NULL,
    "ReservationStartDate" date NOT NULL,
    "ReservationStartTime" time without time zone NOT NULL,
    "isDeleted" boolean NOT NULL,
    "Court_CourtID" integer NOT NULL,
    "Price" integer,
    "Abo" boolean,
    "Kunde_KundenID" integer,
    "Tennisplatz_PlatzID" integer,
    "Invoice_idInvoice" integer NOT NULL,
    "Customer_CustomerID" integer NOT NULL,
    "Reservierer" character varying,
    "AboName" character varying(90),
    "AboWeekDay" character varying(90),
    "AboFromDate" date,
    "AboToDate" date,
    "DateTimeOfReservation" timestamp with time zone,
    "Bezahlt" boolean DEFAULT false,
    "Comment" character varying(200) DEFAULT ''::character varying
);


ALTER TABLE "Roger"."Reservation" OWNER TO roger;

SET search_path = public, pg_catalog;

--
-- Name: settings_sequence; Type: SEQUENCE; Schema: public; Owner: roger
--

CREATE SEQUENCE settings_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.settings_sequence OWNER TO roger;

SET search_path = "Roger", pg_catalog;

--
-- Name: Settings; Type: TABLE; Schema: Roger; Owner: roger; Tablespace: 
--

CREATE TABLE "Settings" (
    "forwardReservationsPerMail" smallint NOT NULL,
    "cashierEmail" character varying,
    "settingsID" integer DEFAULT nextval('public.settings_sequence'::regclass) NOT NULL,
    "deletionLimit" integer NOT NULL,
    locked integer NOT NULL,
    "reservationDateLimit" date
);


ALTER TABLE "Roger"."Settings" OWNER TO roger;

SET search_path = public, pg_catalog;

--
-- Name: zeiten_sequence; Type: SEQUENCE; Schema: public; Owner: roger
--

CREATE SEQUENCE zeiten_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zeiten_sequence OWNER TO roger;

SET search_path = "Roger", pg_catalog;

--
-- Name: Tarife; Type: TABLE; Schema: Roger; Owner: roger; Tablespace: 
--

CREATE TABLE "Tarife" (
    "ZeitId" integer DEFAULT nextval('public.zeiten_sequence'::regclass) NOT NULL,
    "ZeitName" character varying(45) NOT NULL,
    "ZeitVon" time without time zone NOT NULL,
    "ZeitBis" time without time zone NOT NULL,
    "PreisMitglied" integer,
    "PreisNichtMitglied" integer,
    "DatumVon" date,
    "DatumBis" date
);


ALTER TABLE "Roger"."Tarife" OWNER TO roger;

SET search_path = public, pg_catalog;

SET search_path = "Roger", pg_catalog;

--
-- Data for Name: Abo; Type: TABLE DATA; Schema: Roger; Owner: roger
--

INSERT INTO "Abo" VALUES (1, '2011-10-14', '2012-04-10', 'Wintersaison', 0, 100, 150, '06:00:00', '23:00:00');
INSERT INTO "Abo" VALUES (2, '2011-04-01', '2012-04-01', 'Ganzjahressaison', 0, 200, 250, '06:00:00', '23:00:00');
INSERT INTO "Abo" VALUES (6, '2012-11-02', '2013-04-10', 'Winter 2012/2013 bis 16:00', 1, 300, 350, '06:00:00', '15:00:00');
INSERT INTO "Abo" VALUES (7, '2012-11-02', '2013-04-10', 'Winter 2012/2013 ab 16:00', 1, 355, 455, '16:00:00', '23:00:00');
INSERT INTO "Abo" VALUES (8, '2012-11-02', '2012-11-09', 'Testabo', 0, 12, 13, '16:00:00', '23:00:00');


--
-- Data for Name: Authorities; Type: TABLE DATA; Schema: Roger; Owner: postgres
--

INSERT INTO "Authorities" VALUES ('w', 'ROLE_CUSTOMER', 106, 55);
INSERT INTO "Authorities" VALUES ('kkk', 'ROLE_CUSTOMER', 107, 56);
INSERT INTO "Authorities" VALUES ('z', 'ROLE_CUSTOMER', 108, 57);
INSERT INTO "Authorities" VALUES ('uuu', 'ROLE_CUSTOMER', 109, 58);
INSERT INTO "Authorities" VALUES ('u', 'ROLE_CUSTOMER', 110, 59);
INSERT INTO "Authorities" VALUES ('g', 'ROLE_CUSTOMER', 111, 60);
INSERT INTO "Authorities" VALUES ('i', 'ROLE_CUSTOMER', 112, 61);
INSERT INTO "Authorities" VALUES ('t', 'ROLE_CUSTOMER', 113, 62);
INSERT INTO "Authorities" VALUES ('stef', 'ROLE_CUSTOMER', 114, 63);
INSERT INTO "Authorities" VALUES ('f', 'ROLE_CUSTOMER', 115, 64);
INSERT INTO "Authorities" VALUES ('matti', 'ROLE_CUSTOMER', 116, 65);
INSERT INTO "Authorities" VALUES ('sss', 'ROLE_CUSTOMER', 117, 66);
INSERT INTO "Authorities" VALUES ('ui', 'ROLE_CUSTOMER', 118, 67);
INSERT INTO "Authorities" VALUES ('mattii', 'ROLE_CUSTOMER', 119, 68);
INSERT INTO "Authorities" VALUES ('m', 'ROLE_CUSTOMER', 120, 69);
INSERT INTO "Authorities" VALUES ('tteaet', 'ROLE_CUSTOMER', 121, 70);
INSERT INTO "Authorities" VALUES ('1', 'ROLE_CUSTOMER', 122, 71);
INSERT INTO "Authorities" VALUES ('7', 'ROLE_CUSTOMER', 123, 72);
INSERT INTO "Authorities" VALUES ('4444', 'ROLE_CUSTOMER', 124, 73);
INSERT INTO "Authorities" VALUES ('9', 'ROLE_CUSTOMER', 125, 74);
INSERT INTO "Authorities" VALUES ('0', 'ROLE_CUSTOMER', 126, 75);
INSERT INTO "Authorities" VALUES ('o', 'ROLE_CUSTOMER', 127, 76);
INSERT INTO "Authorities" VALUES ('p', 'ROLE_CUSTOMER', 128, 77);
INSERT INTO "Authorities" VALUES ('zzz', 'ROLE_CUSTOMER', 129, 78);
INSERT INTO "Authorities" VALUES ('r', 'ROLE_CUSTOMER', 130, 79);
INSERT INTO "Authorities" VALUES ('etet', 'ROLE_CUSTOMER', 131, 80);
INSERT INTO "Authorities" VALUES ('gustav', 'ROLE_CUSTOMER', 132, 81);
INSERT INTO "Authorities" VALUES ('fritz', 'ROLE_CUSTOMER', 133, 82);
INSERT INTO "Authorities" VALUES ('andreasgraf', 'ROLE_CUSTOMER', 134, 83);
INSERT INTO "Authorities" VALUES ('muster', 'ROLE_CUSTOMER', 135, 84);
INSERT INTO "Authorities" VALUES ('mh123', 'ROLE_CUSTOMER', 136, 85);
INSERT INTO "Authorities" VALUES ('muster', 'ROLE_CUSTOMER', 137, 86);
INSERT INTO "Authorities" VALUES ('test2', 'ROLE_CUSTOMER', 138, 87);
INSERT INTO "Authorities" VALUES ('test3', 'ROLE_CUSTOMER', 139, 88);
INSERT INTO "Authorities" VALUES ('test', 'ROLE_CUSTOMER', 41, 31);
INSERT INTO "Authorities" VALUES ('matthiasheindl', 'ROLE_ADMIN', 140, 42);
INSERT INTO "Authorities" VALUES ('matthiasheindl', 'ROLE_ADMIN', 43, 1);
INSERT INTO "Authorities" VALUES ('matthiasheindl', 'ROLE_CUSTOMER', 44, 1);
INSERT INTO "Authorities" VALUES ('test4', 'ROLE_CUSTOMER', 141, 89);
INSERT INTO "Authorities" VALUES ('kr', 'ROLE_CUSTOMER', 46, 32);
INSERT INTO "Authorities" VALUES ('kr', 'ROLE_CUSTOMER', 47, 33);
INSERT INTO "Authorities" VALUES ('kr', 'ROLE_CUSTOMER', 48, 34);
INSERT INTO "Authorities" VALUES ('kr', 'ROLE_CUSTOMER', 49, 35);
INSERT INTO "Authorities" VALUES ('kr', 'ROLE_CUSTOMER', 50, 36);
INSERT INTO "Authorities" VALUES ('stefanheindl', 'ROLE_CUSTOMER', 51, 37);
INSERT INTO "Authorities" VALUES ('stefan', 'ROLE_CUSTOMER', 52, 38);
INSERT INTO "Authorities" VALUES ('0', 'ROLE_ADMIN', 53, 31);
INSERT INTO "Authorities" VALUES ('test', 'ROLE_CUSTOMER', 54, 39);
INSERT INTO "Authorities" VALUES ('test', 'ROLE_CUSTOMER', 55, 40);
INSERT INTO "Authorities" VALUES ('0', 'ROLE_ADMIN', 56, 40);
INSERT INTO "Authorities" VALUES ('test', 'ROLE_CUSTOMER', 57, 41);
INSERT INTO "Authorities" VALUES ('test5', 'ROLE_CUSTOMER', 142, 90);
INSERT INTO "Authorities" VALUES ('matthiasheindl', 'ROLE_CUSTOMER', 59, 42);
INSERT INTO "Authorities" VALUES ('karl', 'ROLE_CUSTOMER', 143, 91);
INSERT INTO "Authorities" VALUES ('test5666', 'ROLE_CUSTOMER', 144, 92);
INSERT INTO "Authorities" VALUES ('d', 'ROLE_CUSTOMER', 145, 93);
INSERT INTO "Authorities" VALUES ('tz', 'ROLE_CUSTOMER', 146, 94);
INSERT INTO "Authorities" VALUES ('sdfg', 'ROLE_CUSTOMER', 147, 95);
INSERT INTO "Authorities" VALUES ('adgf', 'ROLE_CUSTOMER', 148, 96);
INSERT INTO "Authorities" VALUES ('adsgsdf', 'ROLE_CUSTOMER', 149, 97);
INSERT INTO "Authorities" VALUES ('dfadsf', 'ROLE_CUSTOMER', 150, 98);
INSERT INTO "Authorities" VALUES ('asdfasdf', 'ROLE_CUSTOMER', 151, 99);
INSERT INTO "Authorities" VALUES ('asdfasdfasdf', 'ROLE_CUSTOMER', 152, 100);
INSERT INTO "Authorities" VALUES ('234', 'ROLE_CUSTOMER', 153, 101);
INSERT INTO "Authorities" VALUES ('fhfgfgf', 'ROLE_CUSTOMER', 154, 102);
INSERT INTO "Authorities" VALUES ('yxcv', 'ROLE_CUSTOMER', 155, 103);
INSERT INTO "Authorities" VALUES ('tztz', 'ROLE_CUSTOMER', 156, 104);
INSERT INTO "Authorities" VALUES ('alioöiolu', 'ROLE_CUSTOMER', 157, 105);
INSERT INTO "Authorities" VALUES ('tztzzzzzzz', 'ROLE_CUSTOMER', 158, 106);
INSERT INTO "Authorities" VALUES ('etreter', 'ROLE_CUSTOMER', 159, 107);
INSERT INTO "Authorities" VALUES ('agseghh', 'ROLE_CUSTOMER', 160, 108);
INSERT INTO "Authorities" VALUES ('gfhdfghh', 'ROLE_CUSTOMER', 161, 109);
INSERT INTO "Authorities" VALUES ('adsfhhtth', 'ROLE_CUSTOMER', 162, 110);
INSERT INTO "Authorities" VALUES ('sdfadfadfadfadf', 'ROLE_CUSTOMER', 163, 111);
INSERT INTO "Authorities" VALUES ('rtzerherhj', 'ROLE_CUSTOMER', 164, 112);
INSERT INTO "Authorities" VALUES ('rghhrtr', 'ROLE_CUSTOMER', 165, 113);
INSERT INTO "Authorities" VALUES ('erte', 'ROLE_CUSTOMER', 166, 114);
INSERT INTO "Authorities" VALUES ('gfhjm', 'ROLE_CUSTOMER', 167, 115);
INSERT INTO "Authorities" VALUES ('jtr', 'ROLE_CUSTOMER', 168, 116);
INSERT INTO "Authorities" VALUES ('ggf', 'ROLE_CUSTOMER', 169, 117);
INSERT INTO "Authorities" VALUES ('h', 'ROLE_CUSTOMER', 170, 118);
INSERT INTO "Authorities" VALUES ('ppp', 'ROLE_CUSTOMER', 171, 119);
INSERT INTO "Authorities" VALUES ('ffff', 'ROLE_CUSTOMER', 172, 120);
INSERT INTO "Authorities" VALUES ('iiii', 'ROLE_CUSTOMER', 173, 121);
INSERT INTO "Authorities" VALUES ('hhh', 'ROLE_CUSTOMER', 174, 122);
INSERT INTO "Authorities" VALUES ('matthias', 'ROLE_CUSTOMER', 92, 43);
INSERT INTO "Authorities" VALUES ('matt', 'ROLE_CUSTOMER', 93, 44);
INSERT INTO "Authorities" VALUES ('hansi', 'ROLE_CUSTOMER', 94, 45);
INSERT INTO "Authorities" VALUES ('matthias', 'ROLE_CUSTOMER', 95, 46);
INSERT INTO "Authorities" VALUES ('hansi', 'ROLE_CUSTOMER', 96, 47);
INSERT INTO "Authorities" VALUES ('matthias', 'ROLE_CUSTOMER', 97, 48);
INSERT INTO "Authorities" VALUES ('hansi', 'ROLE_CUSTOMER', 98, 49);
INSERT INTO "Authorities" VALUES ('tttt', 'ROLE_CUSTOMER', 175, 123);
INSERT INTO "Authorities" VALUES ('matthias', 'ROLE_ADMIN', 100, 48);
INSERT INTO "Authorities" VALUES ('ttt', 'ROLE_CUSTOMER', 101, 50);
INSERT INTO "Authorities" VALUES ('asdf', 'ROLE_CUSTOMER', 102, 51);
INSERT INTO "Authorities" VALUES ('aaa', 'ROLE_CUSTOMER', 103, 52);
INSERT INTO "Authorities" VALUES ('a', 'ROLE_CUSTOMER', 104, 53);
INSERT INTO "Authorities" VALUES ('b', 'ROLE_CUSTOMER', 105, 54);
INSERT INTO "Authorities" VALUES ('markushamm', 'ROLE_CUSTOMER', 176, 124);
INSERT INTO "Authorities" VALUES ('markushamm', 'ROLE_ADMIN', 177, 124);


--
-- Data for Name: Court; Type: TABLE DATA; Schema: Roger; Owner: roger
--

INSERT INTO "Court" VALUES (18, 4, 'Platz 4', 0, 1);
INSERT INTO "Court" VALUES (19, 3, 'Platz 3', 0, 1);
INSERT INTO "Court" VALUES (20, 2, 'Platz 2', 0, 1);
INSERT INTO "Court" VALUES (21, 1, 'Platz 1', 0, 1);
INSERT INTO "Court" VALUES (22, 9, 'Halle', 1, 1);
INSERT INTO "Court" VALUES (23, 12, 'Platz 12', 0, 1);
INSERT INTO "Court" VALUES (12, 11, 'Platz 11', 0, 1);
INSERT INTO "Court" VALUES (13, 10, 'Platz 10', 0, 1);
INSERT INTO "Court" VALUES (14, 8, 'Platz 9', 0, 1);
INSERT INTO "Court" VALUES (15, 7, 'Platz 8', 0, 1);
INSERT INTO "Court" VALUES (16, 6, 'Platz 6', 0, 1);
INSERT INTO "Court" VALUES (17, 5, 'Platz 5', 0, 1);


--
-- Data for Name: Customer; Type: TABLE DATA; Schema: Roger; Owner: roger
--

INSERT INTO "Customer" VALUES (95, 'sdfg', 'sdfg', 'sdfg', 'sdfg', '37cb2da2c5e99500534191449e8c4790', false, true, 'a3ccf811-37bb-4a08-8b38-2048ec181e55', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (96, 'adf', 'sdg', 'asdg', 'adgf', '9d78ded07d6c87e2d3367115714c1d25', false, true, 'a91bf1bd-9a0d-47b3-be6c-baecf880c9b3', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (97, 'asdfa^', 'adsf', 'asdf', 'adsgsdf', '3542841c2e46345e3785d048089b32e9', false, true, '127ac3ee-6cfa-4f25-a7d5-709b95061d1b', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (85, 'mh123', 'mh123', 'matthiasheindl@gmx.at', 'mh123', '1e69c843214ca14d0f1ed2bffc95293d', true, true, '26826476-3b7c-4d06-9928-c49ace22cdb8', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (50, 'tt', 'tt', 'matthiasheindl@gmx.at', 'ttt', '9e92001b8e34d5a5e3b960f44aa996fa', false, false, 'eb284610-ce77-4cf3-8067-a85a759fb8ab', '', '', '', '', '1900-01-01', '', '');
INSERT INTO "Customer" VALUES (51, 'asdf', 'asdf', 'matthiasheindl@gmx.at', 'asdf', NULL, false, false, '75dee748-4abc-46d2-99cb-94bdbf43581a', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (52, 'aaa', 'aaa', 'matthiasheindl@gmx.at', 'aaa', NULL, false, false, '8fd8385b-0527-44c5-a2bf-e2309de0d32d', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (53, 'a', 'a', 'matthiasheindl@gmx.at', 'a', NULL, false, false, 'ff38b601-88d8-4616-bc5f-ca0372e530a6', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (54, 'b', 'b', 'b@gmx.at', 'b', NULL, false, false, 'ad60e541-1b32-48fa-b5ef-4195975061eb', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (55, 'w', 'w', 'matthiasheindl@gmx.at', 'w', NULL, false, false, '3d69cced-8664-43d9-8ecc-386ad35f69be', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (56, 'k', 'k', 'matthiasheindl@gmx.at', 'kkk', NULL, false, false, 'c19c14f8-88a6-44a6-918d-912583db4af2', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (57, 'z', 'z', 'z', 'z', NULL, false, false, '18185c23-ab3c-43ad-b22e-97846e5422e2', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (58, 'u', 'u', 'matthiasheindl@gmx.at', 'uuu', NULL, false, false, 'c470a8c6-6e5a-4cf8-a1b9-f68a6b1ccf86', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (59, 'u', 'u', 'u', 'u', NULL, false, false, '53229d20-e9a9-472a-b3cb-697d1579f13b', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (60, 'g', 'g', 'g', 'g', NULL, false, false, 'b359c247-6c91-4840-9a5f-fa73feedd9e8', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (61, 'i', 'i', 'i', 'i', NULL, false, false, '51311349-19da-44b9-af40-cddc89b72c46', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (62, 't', 't', 't', 't', NULL, false, false, '15ab4465-4c5a-4982-8d9e-9f35e64a4fe4', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (63, 'stef', 'stef', 'stef', 'stef', NULL, false, false, '3f6d4596-ce1a-4d6c-bd2b-5115e0c50513', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (64, 'f', 'f', 'f', 'f', NULL, false, false, '43246e88-5ce7-4cef-8423-84698e0e7966', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (65, 'abs', 'a', 'matthiasheindl@gmx.at', 'matti', NULL, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (66, 'a', 's', 's', 'sss', NULL, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (98, 'asdfad', 'asdf', 'asdf', 'dfadsf', '9fd4b3fe88542b42d71fbe9dddbba0fa', false, true, '0d17d1eb-3ff1-4129-a7ab-5b2c438b4fa5', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (67, 'ui', 'ui', 'matthiasheindl@gmx.at', 'ui', NULL, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (68, 'matti', 'matti', 'matthiasheindl@gmx.at', 'mattii', NULL, false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (69, 'matthias', 'heindl', 'matthiasheindl@gmx.at', 'm', NULL, false, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (70, 'testtt', 'test', 'tete', 'tteaet', NULL, false, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (71, '1', '1', '1', '1', NULL, false, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (72, '7', '7', '7', '7', NULL, false, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (73, '7', '7', '7', '4444', NULL, false, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (74, '9', '9', '9', '9', NULL, false, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (75, '0', '0', '0', '0', NULL, false, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (76, 'o', 'o', 'o', 'o', NULL, false, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (77, 'p', 'p', 'p', 'p', NULL, false, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (78, 'z', 'z', 'z', 'zzz', NULL, false, true, '20cceec7-fad8-4396-b056-aba19eebc6ab', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (79, 'r', 'r', 'r', 'r', NULL, false, true, 'cbcb964d-04db-4a93-a693-be246edadfff', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (99, 'asdf', 'asdf', 'asdf', 'asdfasdf', 'bc445a65f95aa3669c10fbc07006a939', false, true, '504c8f69-9fb7-4cd8-b3ff-a6aea07157b6', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (100, 'asdfasdf', 'asdf', 'asdf', 'asdfasdfasdf', '67e38dddadd203dc3cba243eeaab3364', false, true, 'e4e0ea75-e0af-4293-bde9-2282e9a2f08d', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (101, '12', '12', '12', '234', '62897dd4f86ae5984227912f4cb2b2e2', false, true, '2cfbc46e-8402-4da6-ab4c-c4df9282b821', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (102, 'sdfgsdfg', 'sdfg', 'sdfgsdfg', 'fhfgfgf', '2810b393126e6e9dfcaecbd911cee9cb', false, true, '869879d5-26a0-4092-be60-062c38610fa1', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (80, 'etet', 'etet', 'matthiasheindl@gmx.at', 'etet', '5dce12b78d83c321095d67427adca0d2', false, true, 'f33c2e6f-1ac6-4fc7-adb6-b4a03de45781', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (81, 'noch einer', 'noch einer', 'matthiasheindl@gmx.at', 'gustav', 'bb059759afdb7e6e07128b80a8616f48', false, true, '28bbdc6b-cfbc-4e18-af0a-fa7d9dc9517e', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (82, 'fritz', 'fritz', 'matthiasheindl@gmx.at', 'fritz', '724162267ce1111891bbb3611b31a9f2', false, true, '023c75cf-aaa1-4076-bfe6-dfcdac341565', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (83, 'Andreas', 'Graf', 'matthiasheindl@gmx.at', 'andreasgraf', '2efbf8cfd1c214dd14ed0d2d2d107586', true, true, '5581634a-b54b-484b-8309-7a843e059fb1', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (84, NULL, NULL, NULL, NULL, 'bb83f4e7ac6760514385b9a651aec72e', false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (103, 'z', 'z', 'z', 'yxcv', '41121f860730278d598e41abba6c6b61', false, true, 'db8a1b96-a143-49c6-a7ef-8bf55385555a', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (104, 'tz', 'tz', 'tztz', 'tztz', '51fc532dcc57cfdcd53c1d0e97b971d8', false, true, '0ded7c38-1a45-4806-a597-9927e9a61c6e', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (105, 'adsfadf', 'fasdf', 'adsfa', 'alioöiolu', '67e38dddadd203dc3cba243eeaab3364', false, true, '75e9cb7a-337b-4541-b232-8d96fb2d0ebb', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (106, 'tztz', 'tztz', 'tztz', 'tztzzzzzzz', '18c8f58a606514b2e20ddf21272f6b33', false, true, '6f5a5fb3-1a1d-4d1d-a21e-647d29f9ebeb', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (107, 'retet', 'ert', 'rete', 'etreter', 'ef57a6de8aaf3591104c8d1a1e2ca0f6', false, true, 'ef80f0ca-a340-4b48-998e-6d549a6d3edb', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (86, 'hans', 'muster', 'matthiasheindl@gmx.at', 'muster', '1b2b70cb8ff304401729fd790660ff1b', true, true, '90af8a6c-2cba-4304-9788-2818b7995cc1', 'Strasse', '', '', '', '1900-01-01', '', '');
INSERT INTO "Customer" VALUES (41, 'test', 'test', 'matthiasheindl@gmx.at', 'test', 'b896cdead40b0cd5e4d5e700934c21be', true, false, '7e99570a-6c60-4858-bef4-f1dc42071336', '', '', '', '', '1900-01-01', '', '');
INSERT INTO "Customer" VALUES (87, 'test2', 'test2', 'matthiasheindl@gmx.at', 'test2', 'e42d51cbe1459817bf8f074c656b7714', false, true, 'e7e06e84-d7e6-483e-9465-9c204a31279d', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (88, 'test3', 'test3', 'matthiasheindl@gmx.at', 'test3', 'e07e5d45a3c5684b6fa3cafc08b1312f', false, true, '052d360d-761b-4f68-8dc6-38227dd6ee20', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (42, 'Matthias', 'Heindl', 'matthiasheindl@gmx.at', 'matthiasheindl', 'bb83f4e7ac6760514385b9a651aec72e', true, true, 'bc7e1d22-bd8d-4edd-9e0e-cc070eebc406', 'Fischergasse 7', '', '', '', '1900-01-01', '', '');
INSERT INTO "Customer" VALUES (89, 'test', 'test', 'matthiasheindl@gmx.at', 'test4', '08c74cc242ed8018efbf32e50937f6df', false, true, '04f92c1a-e181-47c7-8881-059c8f44dc0e', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (90, 'test5', 'test5', 'matthiasheindl@gmx.at', 'test5', 'e49e4df8d96d3742f1a79774afc9a024', false, true, '32d8a05d-c1c5-4181-9f38-123fc8a91e79', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (91, 'Karl', 'Muster', 'matthiasheindl@gmx.at', 'karl', '8294140c936d7081c94825b320ecb07a', false, true, '726d7017-c611-4ab3-a9e3-19e9965fa9d4', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (92, 'test', 'test', 'test', 'test5666', 'f14bc726eedfbe9860fb12fe9c7c11c9', false, true, 'eab61960-173c-4fd6-9b88-3f1e28b49e0a', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (93, 'd', 'd', 'd', 'd', '53a7ed8e4870c5929b8a332edc4de114', false, true, '8e0d15d0-efc5-4f00-b4e9-087e335685c1', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (94, 'tz', 'tz', 'tz', 'tz', '1b471652368d6b1d6e40e09ab6d198bb', false, true, 'a4e21ba9-eacc-4525-87ff-451b8b770c8b', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (108, 'er', 'wet', 'arg', 'agseghh', '84853f5be9e2c9b5ce930fc2d941858c', false, true, '09395ce2-586a-4dad-a165-e839abd2bd31', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (109, 'adsfadfadsf', 'fasdf', 'adsf', 'gfhdfghh', '9f7f07ebba57363bc0c77cbf6ee95d20', false, true, '4621e923-f215-43e8-970b-94818378f1f7', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (110, 'adsfadfadf', 'asdf', 'asf', 'adsfhhtth', '6a14acb01ffd833b82ac0b2b75f7299d', false, true, '7f6880d4-ee50-4cdb-bdea-149303b87846', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (111, 'adsfadfasdf', 'adsf', 'adsf', 'sdfadfadfadfadf', '77d9117bcf13a2167c3216c514df3061', false, true, '59be9b84-2cc1-417d-8833-0159a3200cde', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (112, '123', '123', '123', 'rtzerherhj', '0402534c762aee765c66593b44f28d17', false, true, '749d6fe5-6478-4da1-b791-f2af7c0e6472', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (113, 'asdfadsf', 'asdf', 'asdf', 'rghhrtr', '9cff0d88abbdeaeaf901251836785f51', false, true, 'e716cbe8-4f28-44e5-a55a-bb1f6d5af923', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (114, 'asdfasdf', 'erte', 'bgfh', 'erte', '841cca38341bbefc2c693739168bdf8f', false, true, '139d7ccf-8613-419d-8176-463e4e56243a', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (115, 'adsfadfasdf', ',,kjh', 'hjk', 'gfhjm', '90dfb54e9546d84083d00e495ee65710', false, true, '515c29c8-ca7e-439e-b17f-80a192e06c29', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (116, 'asdfasdfasdf', 'ads', 'adsf', 'jtr', '37cb2da2c5e99500534191449e8c4790', false, true, '3c740f43-5219-478d-a61b-00b082c3a5fa', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (117, 'fasdff', 'f', 'g', 'ggf', '2f08e710d013a1c94ee4e0bc566f517f', false, true, '7521112b-0f59-4100-803d-c53fe93f1c6b', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (118, 'hj', 'z', 'h', 'h', 'ce5c79df23f54ffd8f39c095a68723fa', false, true, '195f202d-5f7e-4b4a-bd99-21240b51f3ea', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (119, 'p', 'p', 'p', 'ppp', '6e5bdc40d54350766e432e89cd089f9f', false, true, '881305ea-0676-4fc2-907d-e350d8d68ec0', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (120, 'adsfadfadf', 'f', 'fff', 'ffff', '1499851a7a8f5161568d10281f5ca447', false, true, '0a7ff6c4-2ff4-47dd-a2c4-5d08a1d478fb', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (121, 'u', 'i', 'i', 'iiii', '3e59b349fb9e1f9006555b3f3d89a672', false, true, '62570eed-8ff1-41ae-9eed-837d223756f7', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (122, 'h', 'h', 'h', 'hhh', '0bceafcd5edbe755937b176ea279ef95', false, true, '9d27345d-2778-4888-8d16-8bb5b546dd88', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (123, 't', 't', 't', 'tttt', '3ac973490c6af2a079a414353c695f1c', false, true, 'fa1f47a0-7326-4fdf-a0e9-1a1084271d4c', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customer" VALUES (124, 'markus', 'hamm', 'markus.hamm@gmail.com', 'markushamm', '4c53feaa1797d20b8964d5d4e6b3a43d', true, true, '79518947-c8a8-43fe-bac4-314c2f86a4b0', NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: Invoice; Type: TABLE DATA; Schema: Roger; Owner: roger
--

INSERT INTO "Invoice" VALUES (548, '2011-07-02 00:00:00', 1, 21, 0, 1, '0');
INSERT INTO "Invoice" VALUES (554, '2011-07-02 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (547, '2011-07-02 00:00:00', 1, 21, 0, 1, '0');
INSERT INTO "Invoice" VALUES (555, '2011-07-02 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (556, '2011-07-02 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (557, '2011-07-02 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (549, '2011-07-02 00:00:00', 1, 21, 0, 1, '0');
INSERT INTO "Invoice" VALUES (558, '2011-07-02 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (550, '2011-07-02 00:00:00', 1, 63, 0, 3, '0');
INSERT INTO "Invoice" VALUES (559, '2011-07-02 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (560, '2011-07-02 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (561, '2011-07-02 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (562, '2011-07-02 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (546, '2011-07-02 00:00:00', 1, 51, 2, 3, '0');
INSERT INTO "Invoice" VALUES (563, '2011-07-02 00:00:00', 19, 34, 0, 2, '0');
INSERT INTO "Invoice" VALUES (564, '2011-07-02 00:00:00', 19, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (565, '2011-07-02 00:00:00', 19, 42, 0, 2, '0');
INSERT INTO "Invoice" VALUES (566, '2011-07-02 00:00:00', 19, 42, 0, 2, '0');
INSERT INTO "Invoice" VALUES (567, '2011-07-02 00:00:00', 19, 21, 0, 1, '0');
INSERT INTO "Invoice" VALUES (568, '2011-07-02 00:00:00', 19, 21, 0, 1, '0');
INSERT INTO "Invoice" VALUES (569, '2011-07-02 00:00:00', 19, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (570, '2011-07-02 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (571, '2011-07-02 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (551, '2011-07-02 00:00:00', 1, 21, 0, 1, '0');
INSERT INTO "Invoice" VALUES (572, '2011-07-02 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (552, '2011-07-02 00:00:00', 1, 350, 1, 0, '0');
INSERT INTO "Invoice" VALUES (573, '2011-07-02 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (553, '2011-07-02 00:00:00', 1, 17, 0, 1, '0');
INSERT INTO "Invoice" VALUES (632, '2011-09-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (617, '2011-09-09 00:00:00', 1, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (579, '2011-07-03 00:00:00', 19, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (578, '2011-07-03 00:00:00', 19, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (580, '2011-07-03 00:00:00', 19, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (633, '2011-09-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (631, '2011-09-09 00:00:00', 1, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (634, '2011-09-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (574, '2011-07-03 00:00:00', 1, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (588, '2011-07-03 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (589, '2011-07-03 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (581, '2011-07-03 00:00:00', 1, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (590, '2011-07-03 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (591, '2011-07-03 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (582, '2011-07-03 00:00:00', 1, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (592, '2011-07-03 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (593, '2011-07-03 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (576, '2011-07-03 00:00:00', 1, 290, 1, 2, '0');
INSERT INTO "Invoice" VALUES (594, '2011-07-03 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (583, '2011-07-03 00:00:00', 1, 290, 1, 0, '0');
INSERT INTO "Invoice" VALUES (595, '2011-07-03 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (575, '2011-07-03 00:00:00', 1, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (596, '2011-07-03 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (584, '2011-07-03 00:00:00', 1, 580, 2, 0, '0');
INSERT INTO "Invoice" VALUES (597, '2011-07-03 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (585, '2011-07-03 00:00:00', 1, 290, 1, 0, '0');
INSERT INTO "Invoice" VALUES (598, '2011-07-03 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (577, '2011-07-03 00:00:00', 1, 290, 1, 1, '0');
INSERT INTO "Invoice" VALUES (599, '2011-07-03 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (586, '2011-07-03 00:00:00', 1, 290, 1, 0, '0');
INSERT INTO "Invoice" VALUES (600, '2011-07-03 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (587, '2011-07-03 00:00:00', 1, 290, 1, 0, '0');
INSERT INTO "Invoice" VALUES (601, '2011-07-11 00:00:00', 1, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (602, '2011-07-11 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (630, '2011-09-09 00:00:00', 1, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (604, '2011-07-28 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (603, '2011-07-28 00:00:00', 1, 38, 0, 2, '0');
INSERT INTO "Invoice" VALUES (664, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (636, '2011-09-15 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (635, '2011-09-15 00:00:00', 1, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (663, '2011-09-17 00:00:00', 1, 39, 0, 3, '0');
INSERT INTO "Invoice" VALUES (665, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (666, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (662, '2011-09-17 00:00:00', 1, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (611, '2011-09-09 00:00:00', 1, 38, 0, 2, '0');
INSERT INTO "Invoice" VALUES (618, '2011-09-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (608, '2011-09-09 00:00:00', 1, 38, 0, 2, '0');
INSERT INTO "Invoice" VALUES (619, '2011-09-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (612, '2011-09-09 00:00:00', 1, 32, 0, 2, '0');
INSERT INTO "Invoice" VALUES (620, '2011-09-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (605, '2011-09-09 00:00:00', 1, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (621, '2011-09-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (613, '2011-09-09 00:00:00', 1, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (622, '2011-09-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (609, '2011-09-09 00:00:00', 1, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (623, '2011-09-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (614, '2011-09-09 00:00:00', 1, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (624, '2011-09-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (607, '2011-09-09 00:00:00', 1, 38, 0, 2, '0');
INSERT INTO "Invoice" VALUES (625, '2011-09-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (615, '2011-09-09 00:00:00', 1, 38, 0, 2, '0');
INSERT INTO "Invoice" VALUES (626, '2011-09-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (610, '2011-09-09 00:00:00', 1, 64, 0, 4, '0');
INSERT INTO "Invoice" VALUES (627, '2011-09-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (616, '2011-09-09 00:00:00', 1, 38, 0, 2, '0');
INSERT INTO "Invoice" VALUES (628, '2011-09-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (606, '2011-09-09 00:00:00', 1, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (629, '2011-09-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (646, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (639, '2011-09-17 00:00:00', 1, 57, 0, 3, '0');
INSERT INTO "Invoice" VALUES (647, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (642, '2011-09-17 00:00:00', 1, 51, 0, 3, '0');
INSERT INTO "Invoice" VALUES (648, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (638, '2011-09-17 00:00:00', 1, 39, 0, 3, '0');
INSERT INTO "Invoice" VALUES (649, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (643, '2011-09-17 00:00:00', 1, 39, 0, 3, '0');
INSERT INTO "Invoice" VALUES (650, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (651, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (640, '2011-09-17 00:00:00', 1, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (652, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (653, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (654, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (644, '2011-09-17 00:00:00', 1, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (655, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (656, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (637, '2011-09-17 00:00:00', 1, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (657, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (645, '2011-09-17 00:00:00', 1, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (658, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (659, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (660, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (641, '2011-09-17 00:00:00', 1, 38, 0, 2, '0');
INSERT INTO "Invoice" VALUES (661, '2011-09-17 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (688, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (674, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (675, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (669, '2011-09-18 00:00:00', 1, 32, 0, 2, '0');
INSERT INTO "Invoice" VALUES (676, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (670, '2011-09-18 00:00:00', 1, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (677, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (671, '2011-09-18 00:00:00', 1, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (678, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (679, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (672, '2011-09-18 00:00:00', 1, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (680, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (667, '2011-09-18 00:00:00', 1, 57, 0, 3, '0');
INSERT INTO "Invoice" VALUES (681, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (673, '2011-09-18 00:00:00', 1, 38, 0, 2, '0');
INSERT INTO "Invoice" VALUES (682, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (684, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (685, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (683, '2011-09-18 00:00:00', 1, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (686, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (687, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (689, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (690, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (691, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (668, '2011-09-18 00:00:00', 1, 38, 0, 2, '0');
INSERT INTO "Invoice" VALUES (692, '2011-09-18 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (693, '2011-09-19 00:00:00', 1, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (695, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (696, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (694, '2011-09-19 00:00:00', 1, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (697, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (698, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (699, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (700, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (701, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (702, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (703, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (704, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (705, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (706, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (707, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (708, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (709, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (710, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (711, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (712, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (713, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (714, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (715, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (716, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (717, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (718, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (719, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (720, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (721, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (722, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (723, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (724, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (725, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (726, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (727, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (728, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (729, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (730, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (731, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (732, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (733, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (734, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (735, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (736, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (737, '2011-09-19 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (829, '2011-11-20 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (741, '2011-09-19 00:00:00', 31, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (742, '2011-09-19 00:00:00', 31, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (743, '2011-09-19 00:00:00', 31, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (744, '2011-09-19 00:00:00', 31, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (739, '2011-09-19 00:00:00', 31, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (745, '2011-09-19 00:00:00', 31, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (740, '2011-09-19 00:00:00', 31, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (746, '2011-09-19 00:00:00', 31, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (747, '2011-09-19 00:00:00', 31, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (738, '2011-09-19 00:00:00', 31, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (749, '2011-09-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (748, '2011-09-20 00:00:00', 1, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (750, '2011-09-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (751, '2011-09-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (752, '2011-09-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (753, '2011-09-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (754, '2011-09-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (830, '2011-11-20 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (756, '2011-10-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (757, '2011-10-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (758, '2011-10-09 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (755, '2011-10-09 00:00:00', 1, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (849, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (764, '2011-10-15 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (765, '2011-10-15 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (766, '2011-10-15 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (760, '2011-10-15 00:00:00', 1, 38, 0, 2, '0');
INSERT INTO "Invoice" VALUES (767, '2011-10-15 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (768, '2011-10-15 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (769, '2011-10-15 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (761, '2011-10-15 00:00:00', 1, 38, 0, 2, '0');
INSERT INTO "Invoice" VALUES (770, '2011-10-15 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (771, '2011-10-15 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (772, '2011-10-15 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (762, '2011-10-15 00:00:00', 1, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (773, '2011-10-15 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (759, '2011-10-15 00:00:00', 1, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (774, '2011-10-15 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (763, '2011-10-15 00:00:00', 1, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (775, '2011-10-15 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (776, '2011-10-15 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (777, '2011-10-16 00:00:00', 1, 580, 2, 0, '0');
INSERT INTO "Invoice" VALUES (843, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (778, '2011-11-20 00:00:00', 1, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (782, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (780, '2011-11-20 00:00:00', 1, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (783, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (784, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (785, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (786, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (787, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (788, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (789, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (790, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (791, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (792, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (793, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (794, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (795, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (796, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (797, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (798, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (779, '2011-11-20 00:00:00', 1, 290, 1, 1, '0');
INSERT INTO "Invoice" VALUES (799, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (781, '2011-11-20 00:00:00', 1, 290, 1, 0, '0');
INSERT INTO "Invoice" VALUES (800, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (801, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (802, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (803, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (804, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (805, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (806, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (807, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (808, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (809, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (810, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (811, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (812, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (813, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (814, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (815, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (816, '2011-11-20 00:00:00', 1, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (844, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (821, '2011-11-20 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (818, '2011-11-20 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (822, '2011-11-20 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (823, '2011-11-20 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (819, '2011-11-20 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (824, '2011-11-20 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (825, '2011-11-20 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (817, '2011-11-20 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (826, '2011-11-20 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (827, '2011-11-20 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (820, '2011-11-20 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (828, '2011-11-20 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (861, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (845, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (832, '2011-11-21 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (837, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (834, '2011-11-21 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (838, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (850, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (839, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (835, '2011-11-21 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (840, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (833, '2011-11-21 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (841, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (836, '2011-11-21 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (842, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (853, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (846, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (851, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (847, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (855, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (848, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (852, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (854, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (856, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (857, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (858, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (859, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (860, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (862, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (863, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (864, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (865, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (831, '2011-11-21 00:00:00', 42, 58, 0, 4, '0');
INSERT INTO "Invoice" VALUES (866, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (867, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (868, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (869, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (870, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (871, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (872, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (873, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (874, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (875, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (876, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (877, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (878, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (879, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (880, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (881, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (882, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (883, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (884, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (885, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (886, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (887, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (888, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (889, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (890, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (891, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (892, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (893, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (894, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (895, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (896, '2011-11-21 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (898, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (899, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (900, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (901, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (902, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (903, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (904, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (905, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (906, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (907, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (908, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (909, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (910, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (911, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (912, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (913, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (995, '2011-12-02 00:00:00', 41, 76, 0, 4, '0');
INSERT INTO "Invoice" VALUES (914, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (915, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (916, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (917, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (918, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (919, '2011-11-26 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (897, '2011-11-26 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (923, '2011-11-28 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (924, '2011-11-28 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (925, '2011-11-28 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (926, '2011-11-28 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (920, '2011-11-28 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (927, '2011-11-28 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (928, '2011-11-28 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (921, '2011-11-28 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (929, '2011-11-28 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (930, '2011-11-28 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (922, '2011-11-28 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (931, '2011-11-28 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (993, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (994, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1025, '2011-12-02 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (996, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (988, '2011-12-02 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (997, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (998, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (940, '2011-12-02 00:00:00', 42, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (950, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (951, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (952, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (934, '2011-12-02 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (953, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (941, '2011-12-02 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (954, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (935, '2011-12-02 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (955, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (942, '2011-12-02 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (956, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (932, '2011-12-02 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (957, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (943, '2011-12-02 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (958, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (936, '2011-12-02 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (959, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (944, '2011-12-02 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (960, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (937, '2011-12-02 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (961, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (945, '2011-12-02 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (962, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (938, '2011-12-02 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (963, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (946, '2011-12-02 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (964, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (933, '2011-12-02 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (965, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (947, '2011-12-02 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (966, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (939, '2011-12-02 00:00:00', 42, 39, 0, 3, '0');
INSERT INTO "Invoice" VALUES (967, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (968, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (969, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (970, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (971, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (972, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (973, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (974, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (948, '2011-12-02 00:00:00', 42, 45, 0, 3, '0');
INSERT INTO "Invoice" VALUES (975, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (976, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (977, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (978, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (979, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (980, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (981, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (982, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (983, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (984, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (949, '2011-12-02 00:00:00', 42, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (985, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (999, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1000, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1001, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1002, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1003, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1004, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1005, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1006, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1007, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1008, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1009, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (987, '2011-12-02 00:00:00', 42, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (1010, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1011, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1012, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (989, '2011-12-02 00:00:00', 42, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (1013, '2011-12-02 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1014, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (990, '2011-12-02 00:00:00', 42, 39, 0, 3, '0');
INSERT INTO "Invoice" VALUES (1015, '2011-12-02 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1016, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1017, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (991, '2011-12-02 00:00:00', 42, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (1018, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1020, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1021, '2011-12-02 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1026, '2011-12-02 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1022, '2011-12-02 00:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1023, '2011-12-02 00:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1024, '2011-12-02 00:00:00', 0, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (992, '2011-12-02 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1029, '2011-12-02 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1027, '2011-12-02 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1028, '2011-12-02 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1033, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1030, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1031, '2011-12-02 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1032, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1034, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1035, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1036, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1037, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1019, '2011-12-02 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1038, '2011-12-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (986, '2011-12-02 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1041, '2011-12-03 00:00:00', 42, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (1040, '2011-12-03 00:00:00', 42, 290, 1, 1, '0');
INSERT INTO "Invoice" VALUES (1039, '2011-12-03 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1043, '2011-12-03 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1045, '2011-12-03 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1046, '2011-12-03 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1047, '2011-12-03 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1048, '2011-12-03 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1049, '2011-12-03 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1044, '2011-12-03 00:00:00', 41, 290, 1, 0, '0');
INSERT INTO "Invoice" VALUES (1050, '2011-12-03 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1042, '2011-12-03 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1051, '2011-12-04 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1052, '2011-12-04 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1053, '2011-12-04 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1054, '2011-12-04 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1055, '2011-12-08 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1056, '2011-12-08 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1057, '2011-12-16 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1058, '2011-12-16 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1059, '2011-12-17 00:00:00', 42, 290, 1, 0, '0');
INSERT INTO "Invoice" VALUES (1060, '2011-12-24 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1061, '2011-12-24 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1063, '2011-12-25 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1062, '2011-12-25 00:00:00', 42, 290, 1, 0, '0');
INSERT INTO "Invoice" VALUES (1064, '2011-12-25 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1065, '2011-12-25 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1066, '2012-01-01 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1067, '2012-01-01 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1069, '2012-01-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1070, '2012-01-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1071, '2012-01-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1072, '2012-01-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1073, '2012-01-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1074, '2012-01-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1068, '2012-01-02 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1075, '2012-01-07 00:00:00', 84, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1076, '2012-01-07 00:00:00', 84, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1077, '2012-01-07 00:00:00', 84, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1078, '2012-01-07 00:00:00', 84, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1079, '2012-01-07 00:00:00', 84, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1080, '2012-01-07 00:00:00', 84, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1081, '2012-01-07 00:00:00', 84, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1083, '2012-01-08 00:00:00', 84, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1084, '2012-01-08 00:00:00', 84, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1082, '2012-01-08 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1086, '2012-01-08 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1087, '2012-01-08 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1085, '2012-01-08 00:00:00', 42, 38, 0, 2, '0');
INSERT INTO "Invoice" VALUES (1088, '2012-01-08 00:00:00', 84, 57, 0, 3, '0');
INSERT INTO "Invoice" VALUES (1089, '2012-01-08 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1090, '2012-01-13 00:00:00', 84, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1091, '2012-01-13 00:00:00', 84, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1092, '2012-01-13 00:00:00', 84, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1093, '2012-01-13 00:00:00', 84, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1094, '2012-01-13 00:00:00', 84, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1095, '2012-01-13 00:00:00', 84, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (1096, '2012-01-13 00:00:00', 84, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1097, '2012-01-13 00:00:00', 84, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1099, '2012-01-14 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1098, '2012-01-14 00:00:00', 42, 290, 1, 0, '0');
INSERT INTO "Invoice" VALUES (1100, '2012-01-14 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1102, '2012-01-14 00:00:00', 86, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1103, '2012-01-14 00:00:00', 86, 76, 0, 4, '0');
INSERT INTO "Invoice" VALUES (1104, '2012-01-14 00:00:00', 86, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1105, '2012-01-14 00:00:00', 86, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1106, '2012-01-14 00:00:00', 86, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1165, '2012-11-03 00:00:00', 42, 300, 1, 0, '0');
INSERT INTO "Invoice" VALUES (1107, '2012-01-14 00:00:00', 86, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1108, '2012-01-14 00:00:00', 86, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1109, '2012-01-14 00:00:00', 86, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1110, '2012-01-14 00:00:00', 86, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1111, '2012-01-14 00:00:00', 86, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1101, '2012-01-14 00:00:00', 86, 13, 2, 1, '0');
INSERT INTO "Invoice" VALUES (1113, '2012-01-29 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1112, '2012-01-29 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1143, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1140, '2012-11-02 00:00:00', 42, 300, 1, 0, '0');
INSERT INTO "Invoice" VALUES (1144, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1133, '2012-11-02 00:00:00', 42, 355, 1, 1, '0');
INSERT INTO "Invoice" VALUES (1145, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1141, '2012-11-02 00:00:00', 42, 355, 1, 0, '0');
INSERT INTO "Invoice" VALUES (1118, '2012-02-25 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1123, '2012-02-25 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1116, '2012-02-25 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1124, '2012-02-25 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1119, '2012-02-25 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1125, '2012-02-25 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1115, '2012-02-25 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1126, '2012-02-25 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1120, '2012-02-25 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1127, '2012-02-25 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1117, '2012-02-25 00:00:00', 42, 26, 0, 2, '0');
INSERT INTO "Invoice" VALUES (1128, '2012-02-25 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1121, '2012-02-25 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1129, '2012-02-25 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1114, '2012-02-25 00:00:00', 42, 13, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1130, '2012-02-25 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1122, '2012-02-25 00:00:00', 42, 19, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1131, '2012-11-01 00:00:00', 42, 32, 0, 2, '0');
INSERT INTO "Invoice" VALUES (1146, '2012-11-02 00:00:00', 72, 355, 1, 0, '0');
INSERT INTO "Invoice" VALUES (1135, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1132, '2012-11-02 00:00:00', 42, 1000000, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1136, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1134, '2012-11-02 00:00:00', 42, 4, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1137, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1147, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1139, '2012-11-02 00:00:00', 42, 12, 1, 0, '0');
INSERT INTO "Invoice" VALUES (1148, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1142, '2012-11-02 00:00:00', 42, 12, 1, 0, '0');
INSERT INTO "Invoice" VALUES (1149, '2012-11-02 00:00:00', 41, 20, 0, 2, '0');
INSERT INTO "Invoice" VALUES (1150, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1151, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1152, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1153, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1154, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1155, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1156, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1157, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1158, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1159, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1160, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1161, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1162, '2012-11-02 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1138, '2012-11-02 00:00:00', 42, 10, 1, 1, '0');
INSERT INTO "Invoice" VALUES (1164, '2012-11-03 00:00:00', 42, 355, 1, 0, '0');
INSERT INTO "Invoice" VALUES (1166, '2012-11-03 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1163, '2012-11-03 00:00:00', 42, 355, 1, 0, '0');
INSERT INTO "Invoice" VALUES (1167, '2012-11-03 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1168, '2012-11-03 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1169, '2012-11-03 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1172, '2012-11-03 00:00:00', 42, 300, 1, 0, '0');
INSERT INTO "Invoice" VALUES (1175, '2012-11-03 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1171, '2012-11-03 00:00:00', 42, 300, 1, 2, '0');
INSERT INTO "Invoice" VALUES (1176, '2012-11-03 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1173, '2012-11-03 00:00:00', 42, 300, 1, 0, '0');
INSERT INTO "Invoice" VALUES (1177, '2012-11-03 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1170, '2012-11-03 00:00:00', 42, 300, 1, 1, '0');
INSERT INTO "Invoice" VALUES (1178, '2012-11-03 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1174, '2012-11-03 00:00:00', 42, 355, 1, 0, '0');
INSERT INTO "Invoice" VALUES (1179, '2012-11-03 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1181, '2012-11-03 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1180, '2012-11-03 00:00:00', 42, 300, 1, 0, '0');
INSERT INTO "Invoice" VALUES (1182, '2012-11-03 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1192, '2012-11-04 00:00:00', 42, 10, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1183, '2012-11-04 00:00:00', 42, 10, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1193, '2012-11-04 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1194, '2012-11-04 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1185, '2012-11-04 00:00:00', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1195, '2012-11-04 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1196, '2012-11-04 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1186, '2012-11-04 00:00:00', 42, 24, 0, 3, '0');
INSERT INTO "Invoice" VALUES (1197, '2012-11-04 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1198, '2012-11-04 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1187, '2012-11-04 00:00:00', 42, 10, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1199, '2012-11-04 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1188, '2012-11-04 00:00:00', 41, 18, 1, 2, '0');
INSERT INTO "Invoice" VALUES (1190, '2012-11-04 00:00:00', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1191, '2012-11-04 00:00:00', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1200, '2012-11-04 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1201, '2012-11-04 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1189, '2012-11-04 00:00:00', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1202, '2012-11-04 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1203, '2012-11-04 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1204, '2012-11-04 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1205, '2012-11-04 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1206, '2012-11-04 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1184, '2012-11-04 00:00:00', 42, 40, 0, 5, '0');
INSERT INTO "Invoice" VALUES (1207, '2012-11-04 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1208, '2012-11-04 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1209, '2012-11-10 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1210, '2012-11-10 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1217, '2012-11-11 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1218, '2012-11-11 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1219, '2012-11-11 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1220, '2012-11-11 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1221, '2012-11-11 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1222, '2012-11-11 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1211, '2012-11-11 00:00:00', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1223, '2012-11-11 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1212, '2012-11-11 00:00:00', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1225, '2012-11-11 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1226, '2012-11-11 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1213, '2012-11-11 00:00:00', 42, 10, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1227, '2012-11-11 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1228, '2012-11-11 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1229, '2012-11-11 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1214, '2012-11-11 00:00:00', 42, 10, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1230, '2012-11-11 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1215, '2012-11-11 00:00:00', 42, 10, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1231, '2012-11-11 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1216, '2012-11-11 00:00:00', 42, 16, 0, 2, '0');
INSERT INTO "Invoice" VALUES (1232, '2012-11-11 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1233, '2012-11-11 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1224, '2012-11-11 00:00:00', 41, 9, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1234, '2012-11-11 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1235, '2012-11-11 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1236, '2012-11-11 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1237, '2012-11-11 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1238, '2012-11-16 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1302, '2012-11-17 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1301, '2012-11-17 00:00:00', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1303, '2012-11-17 00:00:00', 42, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1239, '2012-11-17 00:00:00', 42, 10, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1304, '2012-11-17 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1305, '2012-11-17 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1306, '2012-11-17 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1307, '2012-11-17 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1308, '2012-11-17 00:00:00', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1309, '0001-03-24 20:11:17 BC', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1310, '2012-11-17 20:47:07', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1240, '2012-11-17 00:00:00', 41, 11, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1311, '2012-11-17 00:00:00', 41, 9, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1312, '2012-11-17 00:00:00', 41, 9, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1313, '2012-11-17 00:00:00', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1314, '2012-11-17 20:51:41', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1315, '2012-11-18 19:29:59', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1316, '2012-11-18 19:30:08', 41, NULL, NULL, NULL, NULL);
INSERT INTO "Invoice" VALUES (1317, '2012-11-18 19:32:59', 41, 9, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1318, '2012-11-18 19:34:35', 41, 9, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1319, '2012-11-24 14:48:11', 41, 9, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1320, '2012-11-24 14:51:22', 41, 9, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1321, '2012-11-24 15:46:04', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1322, '2012-11-24 15:46:38', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1323, '2012-11-24 17:43:54', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1324, '2012-11-24 17:48:32', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1325, '2012-11-24 17:49:31', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1326, '2012-11-24 17:49:51', 42, 16, 0, 2, '0');
INSERT INTO "Invoice" VALUES (1327, '2012-11-24 17:50:23', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1328, '2012-11-24 17:50:52', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1329, '2012-11-24 17:53:36', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1330, '2012-11-24 17:57:54', 42, 8, 0, 1, '0');
INSERT INTO "Invoice" VALUES (1331, '2012-11-24 19:05:03', 42, 10, 0, 1, '0');


--
-- Data for Name: Members; Type: TABLE DATA; Schema: Roger; Owner: roger
--



--
-- Data for Name: Reservation; Type: TABLE DATA; Schema: Roger; Owner: roger
--

INSERT INTO "Reservation" VALUES (3269, '2012-11-05', '15:00:00', false, 22, 300, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.388671+01', false, '');
INSERT INTO "Reservation" VALUES (3272, '2012-11-26', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.407585+01', false, '');
INSERT INTO "Reservation" VALUES (3273, '2012-12-03', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.410083+01', false, '');
INSERT INTO "Reservation" VALUES (3274, '2012-12-10', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.412796+01', false, '');
INSERT INTO "Reservation" VALUES (3275, '2012-12-17', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.415439+01', false, '');
INSERT INTO "Reservation" VALUES (3276, '2012-12-24', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.418871+01', false, '');
INSERT INTO "Reservation" VALUES (3277, '2012-12-31', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.4222+01', false, '');
INSERT INTO "Reservation" VALUES (3278, '2013-01-07', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.424892+01', false, '');
INSERT INTO "Reservation" VALUES (3279, '2013-01-14', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.427505+01', false, '');
INSERT INTO "Reservation" VALUES (3280, '2013-01-21', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.43274+01', false, '');
INSERT INTO "Reservation" VALUES (3281, '2013-01-28', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.457821+01', false, '');
INSERT INTO "Reservation" VALUES (3282, '2013-02-04', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.460986+01', false, '');
INSERT INTO "Reservation" VALUES (3283, '2013-02-11', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.464263+01', false, '');
INSERT INTO "Reservation" VALUES (3284, '2013-02-18', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.467109+01', false, '');
INSERT INTO "Reservation" VALUES (3285, '2013-02-25', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.46984+01', false, '');
INSERT INTO "Reservation" VALUES (3286, '2013-03-04', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.472657+01', false, '');
INSERT INTO "Reservation" VALUES (3287, '2013-03-11', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.475726+01', false, '');
INSERT INTO "Reservation" VALUES (3288, '2013-03-18', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.484359+01', false, '');
INSERT INTO "Reservation" VALUES (3289, '2013-03-25', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.488805+01', false, '');
INSERT INTO "Reservation" VALUES (3290, '2013-04-01', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.505922+01', false, '');
INSERT INTO "Reservation" VALUES (3291, '2013-04-08', '15:00:00', false, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.509055+01', false, '');
INSERT INTO "Reservation" VALUES (3292, '2012-11-04', '06:00:00', false, 22, 300, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.241537+01', false, '');
INSERT INTO "Reservation" VALUES (3295, '2012-11-25', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.250597+01', false, '');
INSERT INTO "Reservation" VALUES (3296, '2012-12-02', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.253206+01', false, '');
INSERT INTO "Reservation" VALUES (3297, '2012-12-09', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.256457+01', false, '');
INSERT INTO "Reservation" VALUES (3298, '2012-12-16', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.260148+01', false, '');
INSERT INTO "Reservation" VALUES (3299, '2012-12-23', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.263641+01', false, '');
INSERT INTO "Reservation" VALUES (3300, '2012-12-30', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.266203+01', false, '');
INSERT INTO "Reservation" VALUES (3301, '2013-01-06', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.26852+01', false, '');
INSERT INTO "Reservation" VALUES (3302, '2013-01-13', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.271048+01', false, '');
INSERT INTO "Reservation" VALUES (3303, '2013-01-20', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.273764+01', false, '');
INSERT INTO "Reservation" VALUES (3304, '2013-01-27', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.276916+01', false, '');
INSERT INTO "Reservation" VALUES (3305, '2013-02-03', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.279558+01', false, '');
INSERT INTO "Reservation" VALUES (3306, '2013-02-10', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.281911+01', false, '');
INSERT INTO "Reservation" VALUES (3307, '2013-02-17', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.284344+01', false, '');
INSERT INTO "Reservation" VALUES (3308, '2013-02-24', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.286667+01', false, '');
INSERT INTO "Reservation" VALUES (3309, '2013-03-03', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.289015+01', false, '');
INSERT INTO "Reservation" VALUES (3310, '2013-03-10', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.291742+01', false, '');
INSERT INTO "Reservation" VALUES (3311, '2013-03-17', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.295383+01', false, '');
INSERT INTO "Reservation" VALUES (3312, '2013-03-24', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.298081+01', false, '');
INSERT INTO "Reservation" VALUES (3313, '2013-03-31', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.30064+01', false, '');
INSERT INTO "Reservation" VALUES (3314, '2013-04-07', '06:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.302944+01', false, '');
INSERT INTO "Reservation" VALUES (3355, '2012-11-07', '12:00:00', false, 22, 8, false, NULL, NULL, 1191, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:45:15.24112+01', false, '');
INSERT INTO "Reservation" VALUES (3354, '2012-11-07', '09:00:00', true, 22, 8, false, NULL, NULL, 1190, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:44:56.09013+01', false, '');
INSERT INTO "Reservation" VALUES (3364, '2012-11-11', '15:00:00', false, 22, 0, false, NULL, NULL, 1211, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-11 10:29:20.167523+01', false, '');
INSERT INTO "Reservation" VALUES (3365, '2012-11-11', '14:00:00', false, 22, 8, false, NULL, NULL, 1212, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-11 10:29:51.667474+01', false, '');
INSERT INTO "Reservation" VALUES (3270, '2012-11-12', '15:00:00', true, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.401971+01', false, '');
INSERT INTO "Reservation" VALUES (3293, '2012-11-11', '06:00:00', false, 22, 0, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.24505+01', false, '');
INSERT INTO "Reservation" VALUES (3294, '2012-11-18', '06:00:00', true, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Sonntag', '2012-11-02', '2013-04-10', '2012-11-03 17:11:02.247852+01', false, '');
INSERT INTO "Reservation" VALUES (2812, '2011-10-17', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2813, '2011-10-24', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2814, '2011-10-31', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2815, '2011-11-07', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2816, '2011-11-14', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2817, '2011-11-21', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2818, '2011-11-28', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2819, '2011-12-05', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2820, '2011-12-12', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2821, '2011-12-19', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2822, '2011-12-26', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2823, '2012-01-02', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3271, '2012-11-19', '15:00:00', true, 22, NULL, true, NULL, NULL, 1180, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 17:04:05.404876+01', false, '');
INSERT INTO "Reservation" VALUES (3356, '2012-11-07', '10:00:00', false, 22, 8, false, NULL, NULL, 1191, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:47:05.390504+01', false, '');
INSERT INTO "Reservation" VALUES (3358, '2012-11-08', '11:00:00', false, 22, 8, false, NULL, NULL, 1184, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:47:21.015864+01', false, '');
INSERT INTO "Reservation" VALUES (3359, '2012-11-09', '11:00:00', false, 22, 8, false, NULL, NULL, 1184, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:47:21.055452+01', false, '');
INSERT INTO "Reservation" VALUES (3360, '2012-11-10', '11:00:00', false, 22, 8, false, NULL, NULL, 1184, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:47:21.094859+01', false, '');
INSERT INTO "Reservation" VALUES (3362, '2012-11-06', '10:00:00', true, 22, 8, false, NULL, NULL, 1192, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:48:47.752423+01', false, '');
INSERT INTO "Reservation" VALUES (3315, '2012-11-04', '18:00:00', true, 22, 10, false, NULL, NULL, 1183, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 11:19:44.379631+01', false, '');
INSERT INTO "Reservation" VALUES (3361, '2012-11-11', '11:00:00', true, 22, 8, false, NULL, NULL, 1184, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:47:21.101422+01', false, '');
INSERT INTO "Reservation" VALUES (3366, '2012-11-11', '19:00:00', true, 22, 0, false, NULL, NULL, 1224, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-11 15:25:00.647555+01', false, '');
INSERT INTO "Reservation" VALUES (2856, '2011-10-19', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2857, '2011-10-26', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2858, '2011-11-02', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2859, '2011-11-09', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2824, '2012-01-09', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2825, '2012-01-16', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2826, '2012-01-23', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2675, '2011-10-24', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2679, '2011-11-21', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2827, '2012-01-30', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2828, '2012-02-06', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2850, '2012-01-15', '11:00:00', true, 22, 13, false, NULL, NULL, 1101, 86, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2849, '2012-01-15', '10:00:00', true, 22, 13, false, NULL, NULL, 1101, 86, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2829, '2012-02-13', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2830, '2012-02-20', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2831, '2012-02-27', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2832, '2012-03-05', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2833, '2012-03-12', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2834, '2012-03-19', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2835, '2012-03-26', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2836, '2012-04-02', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2837, '2012-04-09', '14:00:00', false, 22, 0, true, NULL, NULL, 1098, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2860, '2011-11-16', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2861, '2011-11-23', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2862, '2011-11-30', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2863, '2011-12-07', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2864, '2011-12-14', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2865, '2011-12-21', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2866, '2011-12-28', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2867, '2012-01-04', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2868, '2012-01-11', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2869, '2012-01-18', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2870, '2012-01-25', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2871, '2012-02-01', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2872, '2012-02-08', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2873, '2012-02-15', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2874, '2012-02-22', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2875, '2012-02-29', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2876, '2012-03-07', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2877, '2012-03-14', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2878, '2012-03-21', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2879, '2012-03-28', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2880, '2012-04-04', '06:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2881, '2011-10-19', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2882, '2011-10-26', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2883, '2011-11-02', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2884, '2011-11-09', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2885, '2011-11-16', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2886, '2011-11-23', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2887, '2011-11-30', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2888, '2011-12-07', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2889, '2011-12-14', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2890, '2011-12-21', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2891, '2011-12-28', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2892, '2012-01-04', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2893, '2012-01-11', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2894, '2012-01-18', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2895, '2012-01-25', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2896, '2012-02-01', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2897, '2012-02-08', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2898, '2012-02-15', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2899, '2012-02-22', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2756, '2011-11-07', '15:00:00', true, 22, 0, false, NULL, NULL, 1062, 42, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2900, '2012-02-29', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2901, '2012-03-07', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2902, '2012-03-14', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2903, '2012-03-21', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2904, '2012-03-28', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2905, '2012-04-04', '07:00:00', false, 22, 0, true, NULL, NULL, 1101, 86, 'Hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3384, '2012-11-18', '18:00:00', true, 22, 11, false, NULL, NULL, 1240, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-17 20:36:34.647118+01', false, '');
INSERT INTO "Reservation" VALUES (3391, '2012-11-19', '10:00:00', true, 22, 9, false, NULL, NULL, 1317, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-18 19:33:02.183795+01', false, '');
INSERT INTO "Reservation" VALUES (3357, '2012-11-07', '11:00:00', true, 22, 8, false, NULL, NULL, 1184, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:47:20.987682+01', false, '');
INSERT INTO "Reservation" VALUES (3398, '2012-11-25', '12:00:00', false, 22, 8, false, NULL, NULL, 1324, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-24 17:48:33.829218+01', false, '');
INSERT INTO "Reservation" VALUES (3399, '2012-11-25', '11:00:00', false, 22, 8, false, NULL, NULL, 1325, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-24 17:49:33.28173+01', false, '');
INSERT INTO "Reservation" VALUES (3402, '2012-11-21', '10:00:00', false, 22, 8, false, NULL, NULL, 1327, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-24 17:50:24.613095+01', false, '');
INSERT INTO "Reservation" VALUES (3403, '2012-11-23', '11:00:00', false, 22, 8, false, NULL, NULL, 1328, 42, 'Matthias H', NULL, NULL, NULL, NULL, '2012-11-24 17:50:53.195822+01', false, '');
INSERT INTO "Reservation" VALUES (3404, '2012-11-23', '14:00:00', false, 22, 8, false, NULL, NULL, 1329, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-24 17:53:38.122503+01', false, '');
INSERT INTO "Reservation" VALUES (3400, '2012-11-22', '08:00:00', true, 22, 8, false, NULL, NULL, 1326, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-24 17:49:53.220628+01', false, '');
INSERT INTO "Reservation" VALUES (3401, '2012-11-22', '09:00:00', true, 22, 8, false, NULL, NULL, 1326, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-24 17:49:53.224745+01', false, '');
INSERT INTO "Reservation" VALUES (3405, '2012-11-22', '09:00:00', false, 22, 8, false, NULL, NULL, 1330, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-24 17:57:55.562098+01', false, '');
INSERT INTO "Reservation" VALUES (2686, '2012-01-09', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2789, '2012-01-08', '12:00:00', true, 22, 13, false, NULL, NULL, 1077, 84, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2939, '2012-11-05', '06:00:00', true, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3037, '2012-11-05', '23:00:00', true, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3316, '2012-11-04', '15:00:00', false, 22, 8, false, NULL, NULL, 1184, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 14:47:43.404404+01', false, '');
INSERT INTO "Reservation" VALUES (3317, '2012-11-05', '22:00:00', true, 22, 10, false, NULL, NULL, 1183, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 14:50:51.415345+01', false, '');
INSERT INTO "Reservation" VALUES (3363, '2012-11-04', '18:00:00', false, 22, 10, false, NULL, NULL, 1192, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 16:57:49.043373+01', false, '');
INSERT INTO "Reservation" VALUES (3367, '2012-11-11', '21:00:00', false, 22, 11, false, NULL, NULL, 1224, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-11 15:28:24.415604+01', false, '');
INSERT INTO "Reservation" VALUES (3368, '2012-11-11', '20:00:00', false, 22, 10, false, NULL, NULL, 1213, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-11 15:29:28.112569+01', false, '');
INSERT INTO "Reservation" VALUES (3370, '2012-11-11', '22:00:00', false, 22, 11, false, NULL, NULL, 1224, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-11 15:38:50.114465+01', false, '');
INSERT INTO "Reservation" VALUES (3369, '2012-11-11', '18:00:00', true, 22, 11, false, NULL, NULL, 1224, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-11 15:34:29.180755+01', false, '');
INSERT INTO "Reservation" VALUES (3247, '2012-11-14', '16:00:00', false, 22, 100, true, NULL, NULL, 1165, 42, 'YYY', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.071748+01', false, '');
INSERT INTO "Reservation" VALUES (3385, '2012-11-18', '17:00:00', false, 22, 11, false, NULL, NULL, 1240, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-17 20:45:14.000021+01', false, '');
INSERT INTO "Reservation" VALUES (3392, '2012-11-19', '11:00:00', true, 22, 9, false, NULL, NULL, 1318, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-18 19:34:37.315128+01', false, '');
INSERT INTO "Reservation" VALUES (3406, '2012-11-22', '21:00:00', false, 22, 10, false, NULL, NULL, 1331, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-24 19:05:04.939537+01', false, '');
INSERT INTO "Reservation" VALUES (2937, '2012-11-03', '14:00:00', true, 22, 4, false, NULL, NULL, 1134, 42, '', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2701, '2011-10-25', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, '', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2709, '2011-12-20', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2711, '2012-01-03', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2713, '2012-01-17', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2714, '2012-01-24', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2715, '2012-01-31', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2716, '2012-02-07', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2705, '2011-11-22', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2717, '2012-02-14', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2718, '2012-02-21', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3318, '2012-11-05', '10:00:00', true, 22, 8, false, NULL, NULL, 1185, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:07:01.642256+01', false, '');
INSERT INTO "Reservation" VALUES (3371, '2012-11-11', '17:00:00', false, 22, 10, false, NULL, NULL, 1214, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-11 15:43:31.918947+01', false, '');
INSERT INTO "Reservation" VALUES (3377, '2012-11-17', '14:00:00', false, 22, 8, false, NULL, NULL, 1239, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-17 20:31:03.30678+01', false, '');
INSERT INTO "Reservation" VALUES (3378, '2012-11-17', '15:00:00', false, 22, 8, false, NULL, NULL, 1301, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-17 20:31:17.360085+01', false, '');
INSERT INTO "Reservation" VALUES (3379, '2012-11-17', '16:00:00', false, 22, 10, false, NULL, NULL, 1239, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-17 20:31:29.240276+01', false, '');
INSERT INTO "Reservation" VALUES (3381, '2012-11-18', '22:00:00', false, 22, 11, false, NULL, NULL, 1240, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-17 20:32:58.196094+01', false, '');
INSERT INTO "Reservation" VALUES (3386, '2012-11-18', '16:00:00', false, 22, 11, false, NULL, NULL, 1240, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-17 20:47:09.763069+01', false, '');
INSERT INTO "Reservation" VALUES (3380, '2012-11-18', '21:00:00', false, 22, 11, false, NULL, NULL, 1240, 41, 'Hallo Anze', NULL, NULL, NULL, NULL, '2012-11-17 20:32:39.928628+01', false, '');
INSERT INTO "Reservation" VALUES (3045, '2012-12-31', '23:00:00', true, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2973, '2013-01-18', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3083, '2012-11-04', '20:00:00', true, 22, 10, false, NULL, NULL, 1170, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 11:09:01.611394+01', false, '');
INSERT INTO "Reservation" VALUES (3084, '2012-11-04', '21:00:00', true, 22, 10, false, NULL, NULL, 1171, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 11:09:22.889779+01', false, '');
INSERT INTO "Reservation" VALUES (3319, '2012-11-05', '10:00:00', false, 22, 8, false, NULL, NULL, 1185, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:12:37.675027+01', false, '');
INSERT INTO "Reservation" VALUES (3322, '2012-11-06', '12:00:00', true, 22, 8, false, NULL, NULL, 1186, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:13:28.862955+01', false, '');
INSERT INTO "Reservation" VALUES (3323, '2012-11-06', '13:00:00', true, 22, 8, false, NULL, NULL, 1186, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:13:28.867136+01', false, '');
INSERT INTO "Reservation" VALUES (3324, '2012-11-05', '11:00:00', false, 22, 8, false, NULL, NULL, 1187, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:14:14.533852+01', false, '');
INSERT INTO "Reservation" VALUES (3326, '2013-04-15', '10:00:00', false, 22, 10, false, NULL, NULL, 1187, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:16:02.890299+01', false, '');
INSERT INTO "Reservation" VALUES (3321, '2012-11-06', '11:00:00', true, 22, 8, false, NULL, NULL, 1186, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:13:28.858258+01', false, '');
INSERT INTO "Reservation" VALUES (3325, '2012-11-06', '11:00:00', true, 22, 8, false, NULL, NULL, 1187, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:14:14.537762+01', false, '');
INSERT INTO "Reservation" VALUES (3110, '2012-11-12', '08:00:00', true, 22, 300, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.333088+01', false, '');
INSERT INTO "Reservation" VALUES (3372, '2012-11-13', '16:00:00', false, 22, 10, false, NULL, NULL, 1215, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-11 15:47:42.410527+01', false, '');
INSERT INTO "Reservation" VALUES (3085, '2012-11-04', '22:00:00', false, 22, 10, false, NULL, NULL, 1171, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 11:09:22.893579+01', false, '');
INSERT INTO "Reservation" VALUES (3086, '2012-11-05', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.448001+01', false, '');
INSERT INTO "Reservation" VALUES (3089, '2012-11-26', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.45574+01', false, '');
INSERT INTO "Reservation" VALUES (3090, '2012-12-03', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.458769+01', false, '');
INSERT INTO "Reservation" VALUES (3091, '2012-12-10', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.462191+01', false, '');
INSERT INTO "Reservation" VALUES (3092, '2012-12-17', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.464878+01', false, '');
INSERT INTO "Reservation" VALUES (3093, '2012-12-24', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.469222+01', false, '');
INSERT INTO "Reservation" VALUES (3094, '2012-12-31', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.472755+01', false, '');
INSERT INTO "Reservation" VALUES (3095, '2013-01-07', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.475244+01', false, '');
INSERT INTO "Reservation" VALUES (3096, '2013-01-14', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.478199+01', false, '');
INSERT INTO "Reservation" VALUES (3097, '2013-01-21', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.480738+01', false, '');
INSERT INTO "Reservation" VALUES (3098, '2013-01-28', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.483132+01', false, '');
INSERT INTO "Reservation" VALUES (3099, '2013-02-04', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.485535+01', false, '');
INSERT INTO "Reservation" VALUES (3100, '2013-02-11', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.487904+01', false, '');
INSERT INTO "Reservation" VALUES (3101, '2013-02-18', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.491116+01', false, '');
INSERT INTO "Reservation" VALUES (3102, '2013-02-25', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.493703+01', false, '');
INSERT INTO "Reservation" VALUES (3103, '2013-03-04', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.496044+01', false, '');
INSERT INTO "Reservation" VALUES (3104, '2013-03-11', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.49884+01', false, '');
INSERT INTO "Reservation" VALUES (3105, '2013-03-18', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.504234+01', false, '');
INSERT INTO "Reservation" VALUES (3106, '2013-03-25', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.508036+01', false, '');
INSERT INTO "Reservation" VALUES (3107, '2013-04-01', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.512775+01', false, '');
INSERT INTO "Reservation" VALUES (3108, '2013-04-08', '21:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.515589+01', false, '');
INSERT INTO "Reservation" VALUES (3112, '2012-11-26', '08:00:00', false, 22, 300, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.342027+01', false, '');
INSERT INTO "Reservation" VALUES (3113, '2012-12-03', '08:00:00', false, 22, 300, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.345527+01', false, '');
INSERT INTO "Reservation" VALUES (3114, '2012-12-10', '08:00:00', false, 22, 300, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.348343+01', false, '');
INSERT INTO "Reservation" VALUES (3115, '2012-12-17', '08:00:00', false, 22, 300, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.350958+01', false, '');
INSERT INTO "Reservation" VALUES (3116, '2012-12-24', '08:00:00', false, 22, 300, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.353595+01', false, '');
INSERT INTO "Reservation" VALUES (3117, '2012-12-31', '08:00:00', false, 22, 300, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.356229+01', false, '');
INSERT INTO "Reservation" VALUES (3118, '2013-01-07', '08:00:00', false, 22, NULL, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.367716+01', false, '');
INSERT INTO "Reservation" VALUES (3119, '2013-01-14', '08:00:00', false, 22, NULL, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.370798+01', false, '');
INSERT INTO "Reservation" VALUES (3120, '2013-01-21', '08:00:00', false, 22, NULL, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.37422+01', false, '');
INSERT INTO "Reservation" VALUES (3121, '2013-01-28', '08:00:00', false, 22, NULL, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.377521+01', false, '');
INSERT INTO "Reservation" VALUES (3122, '2013-02-04', '08:00:00', false, 22, NULL, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.382256+01', false, '');
INSERT INTO "Reservation" VALUES (3123, '2013-02-11', '08:00:00', false, 22, NULL, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.398309+01', false, '');
INSERT INTO "Reservation" VALUES (3124, '2013-02-18', '08:00:00', false, 22, NULL, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.401898+01', false, '');
INSERT INTO "Reservation" VALUES (3125, '2013-02-25', '08:00:00', false, 22, NULL, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.40835+01', false, '');
INSERT INTO "Reservation" VALUES (3126, '2013-03-04', '08:00:00', false, 22, NULL, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.411754+01', false, '');
INSERT INTO "Reservation" VALUES (3127, '2013-03-11', '08:00:00', false, 22, NULL, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.415553+01', false, '');
INSERT INTO "Reservation" VALUES (3128, '2013-03-18', '08:00:00', false, 22, NULL, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.419709+01', false, '');
INSERT INTO "Reservation" VALUES (3129, '2013-03-25', '08:00:00', false, 22, NULL, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.422824+01', false, '');
INSERT INTO "Reservation" VALUES (3130, '2013-04-01', '08:00:00', false, 22, NULL, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.42575+01', false, '');
INSERT INTO "Reservation" VALUES (3131, '2013-04-08', '08:00:00', false, 22, NULL, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.434715+01', false, '');
INSERT INTO "Reservation" VALUES (3376, '2012-11-14', '13:00:00', false, 22, 9, false, NULL, NULL, 1224, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-11 15:51:31.752886+01', false, '');
INSERT INTO "Reservation" VALUES (3109, '2012-11-05', '08:00:00', true, 22, 300, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.328726+01', false, '');
INSERT INTO "Reservation" VALUES (3375, '2012-11-14', '14:00:00', true, 22, 9, false, NULL, NULL, 1224, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-11 15:48:49.652898+01', false, '');
INSERT INTO "Reservation" VALUES (3373, '2012-11-13', '14:00:00', true, 22, 8, false, NULL, NULL, 1216, 42, '', NULL, NULL, NULL, NULL, '2012-11-11 15:48:12.183477+01', false, '');
INSERT INTO "Reservation" VALUES (3387, '2012-11-18', '15:00:00', false, 22, 9, false, NULL, NULL, 1311, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-17 20:49:50.161461+01', false, '');
INSERT INTO "Reservation" VALUES (3374, '2012-11-13', '15:00:00', false, 22, 10, false, NULL, NULL, 1216, 42, 'YYY', NULL, NULL, NULL, NULL, '2012-11-11 15:48:12.186897+01', false, '');
INSERT INTO "Reservation" VALUES (3388, '2012-11-18', '14:00:00', false, 22, 9, false, NULL, NULL, 1312, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-17 20:50:00.302286+01', false, '');
INSERT INTO "Reservation" VALUES (3087, '2012-11-12', '21:00:00', true, 22, 0, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.450376+01', false, '');
INSERT INTO "Reservation" VALUES (3382, '2012-11-18', '20:00:00', false, 22, 11, false, NULL, NULL, 1240, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-17 20:34:37.351315+01', false, '');
INSERT INTO "Reservation" VALUES (3389, '2012-11-18', '13:00:00', false, 22, 8, false, NULL, NULL, 1313, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-17 20:50:14.205071+01', false, '');
INSERT INTO "Reservation" VALUES (3111, '2012-11-19', '08:00:00', true, 22, 300, true, NULL, NULL, 1172, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:20:08.338825+01', false, '');
INSERT INTO "Reservation" VALUES (3320, '2012-11-05', '12:00:00', true, 22, 8, false, NULL, NULL, 1186, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:12:49.425805+01', false, '');
INSERT INTO "Reservation" VALUES (3393, '2012-11-25', '12:00:00', true, 22, 9, false, NULL, NULL, 1319, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-24 14:48:13.065929+01', false, '');
INSERT INTO "Reservation" VALUES (3088, '2012-11-19', '21:00:00', true, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 11:10:16.453203+01', false, '');
INSERT INTO "Reservation" VALUES (3394, '2012-11-25', '14:00:00', true, 22, 9, false, NULL, NULL, 1320, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-24 14:51:23.726029+01', false, '');
INSERT INTO "Reservation" VALUES (3132, '2012-11-02', '08:00:00', false, 22, 300, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.083873+01', false, '');
INSERT INTO "Reservation" VALUES (3136, '2012-11-30', '08:00:00', false, 22, 300, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.095691+01', false, '');
INSERT INTO "Reservation" VALUES (3137, '2012-12-07', '08:00:00', false, 22, 300, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.098472+01', false, '');
INSERT INTO "Reservation" VALUES (3139, '2012-12-21', '08:00:00', false, 22, 300, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.105126+01', false, '');
INSERT INTO "Reservation" VALUES (3140, '2012-12-28', '08:00:00', false, 22, 300, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.108178+01', false, '');
INSERT INTO "Reservation" VALUES (3141, '2013-01-04', '08:00:00', false, 22, NULL, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.111262+01', false, '');
INSERT INTO "Reservation" VALUES (3142, '2013-01-11', '08:00:00', false, 22, NULL, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.114113+01', false, '');
INSERT INTO "Reservation" VALUES (3143, '2013-01-18', '08:00:00', false, 22, NULL, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.11701+01', false, '');
INSERT INTO "Reservation" VALUES (3144, '2013-01-25', '08:00:00', false, 22, NULL, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.11944+01', false, '');
INSERT INTO "Reservation" VALUES (3145, '2013-02-01', '08:00:00', false, 22, NULL, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.122275+01', false, '');
INSERT INTO "Reservation" VALUES (3146, '2013-02-08', '08:00:00', false, 22, NULL, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.125059+01', false, '');
INSERT INTO "Reservation" VALUES (3147, '2013-02-15', '08:00:00', false, 22, NULL, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.127806+01', false, '');
INSERT INTO "Reservation" VALUES (3148, '2013-02-22', '08:00:00', false, 22, NULL, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.130567+01', false, '');
INSERT INTO "Reservation" VALUES (3149, '2013-03-01', '08:00:00', false, 22, NULL, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.133687+01', false, '');
INSERT INTO "Reservation" VALUES (3150, '2013-03-08', '08:00:00', false, 22, NULL, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.137071+01', false, '');
INSERT INTO "Reservation" VALUES (3151, '2013-03-15', '08:00:00', false, 22, NULL, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.140478+01', false, '');
INSERT INTO "Reservation" VALUES (3152, '2013-03-22', '08:00:00', false, 22, NULL, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.144813+01', false, '');
INSERT INTO "Reservation" VALUES (3153, '2013-03-29', '08:00:00', false, 22, NULL, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.147842+01', false, '');
INSERT INTO "Reservation" VALUES (3154, '2013-04-05', '08:00:00', false, 22, NULL, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.150937+01', false, '');
INSERT INTO "Reservation" VALUES (3156, '2012-11-14', '07:00:00', false, 22, 300, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.706783+01', false, '');
INSERT INTO "Reservation" VALUES (3158, '2012-11-28', '07:00:00', false, 22, 300, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.740499+01', false, '');
INSERT INTO "Reservation" VALUES (3159, '2012-12-05', '07:00:00', false, 22, 300, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.746134+01', false, '');
INSERT INTO "Reservation" VALUES (3160, '2012-12-12', '07:00:00', false, 22, 300, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.751026+01', false, '');
INSERT INTO "Reservation" VALUES (3161, '2012-12-19', '07:00:00', false, 22, 300, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.755444+01', false, '');
INSERT INTO "Reservation" VALUES (3162, '2012-12-26', '07:00:00', false, 22, 300, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.75878+01', false, '');
INSERT INTO "Reservation" VALUES (3163, '2013-01-02', '07:00:00', false, 22, NULL, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.772831+01', false, '');
INSERT INTO "Reservation" VALUES (3164, '2013-01-09', '07:00:00', false, 22, NULL, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.776527+01', false, '');
INSERT INTO "Reservation" VALUES (3165, '2013-01-16', '07:00:00', false, 22, NULL, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.779989+01', false, '');
INSERT INTO "Reservation" VALUES (3166, '2013-01-23', '07:00:00', false, 22, NULL, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.784437+01', false, '');
INSERT INTO "Reservation" VALUES (3167, '2013-01-30', '07:00:00', false, 22, NULL, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.791702+01', false, '');
INSERT INTO "Reservation" VALUES (3168, '2013-02-06', '07:00:00', false, 22, NULL, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.795055+01', false, '');
INSERT INTO "Reservation" VALUES (3169, '2013-02-13', '07:00:00', false, 22, NULL, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.799893+01', false, '');
INSERT INTO "Reservation" VALUES (3170, '2013-02-20', '07:00:00', false, 22, NULL, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.803472+01', false, '');
INSERT INTO "Reservation" VALUES (3171, '2013-02-27', '07:00:00', false, 22, NULL, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.806196+01', false, '');
INSERT INTO "Reservation" VALUES (3172, '2013-03-06', '07:00:00', false, 22, NULL, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.808818+01', false, '');
INSERT INTO "Reservation" VALUES (3173, '2013-03-13', '07:00:00', false, 22, NULL, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.812087+01', false, '');
INSERT INTO "Reservation" VALUES (3174, '2013-03-20', '07:00:00', false, 22, NULL, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.846766+01', false, '');
INSERT INTO "Reservation" VALUES (3175, '2013-03-27', '07:00:00', false, 22, NULL, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.852154+01', false, '');
INSERT INTO "Reservation" VALUES (3176, '2013-04-03', '07:00:00', false, 22, NULL, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.855716+01', false, '');
INSERT INTO "Reservation" VALUES (3177, '2013-04-10', '07:00:00', false, 22, NULL, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.859177+01', false, '');
INSERT INTO "Reservation" VALUES (3178, '2012-11-08', '06:00:00', false, 22, 300, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.311084+01', false, '');
INSERT INTO "Reservation" VALUES (3179, '2012-11-15', '06:00:00', false, 22, 300, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.392567+01', false, '');
INSERT INTO "Reservation" VALUES (3181, '2012-11-29', '06:00:00', false, 22, 300, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.401029+01', false, '');
INSERT INTO "Reservation" VALUES (3182, '2012-12-06', '06:00:00', false, 22, 300, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.407593+01', false, '');
INSERT INTO "Reservation" VALUES (3183, '2012-12-13', '06:00:00', false, 22, 300, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.411669+01', false, '');
INSERT INTO "Reservation" VALUES (3184, '2012-12-20', '06:00:00', false, 22, 300, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.416605+01', false, '');
INSERT INTO "Reservation" VALUES (3185, '2012-12-27', '06:00:00', false, 22, 300, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.428432+01', false, '');
INSERT INTO "Reservation" VALUES (3186, '2013-01-03', '06:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.522814+01', false, '');
INSERT INTO "Reservation" VALUES (3187, '2013-01-10', '06:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.526488+01', false, '');
INSERT INTO "Reservation" VALUES (3188, '2013-01-17', '06:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.529565+01', false, '');
INSERT INTO "Reservation" VALUES (3189, '2013-01-24', '06:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.532584+01', false, '');
INSERT INTO "Reservation" VALUES (3190, '2013-01-31', '06:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.537351+01', false, '');
INSERT INTO "Reservation" VALUES (3191, '2013-02-07', '06:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.548102+01', false, '');
INSERT INTO "Reservation" VALUES (3192, '2013-02-14', '06:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.552668+01', false, '');
INSERT INTO "Reservation" VALUES (3193, '2013-02-21', '06:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.555813+01', false, '');
INSERT INTO "Reservation" VALUES (3194, '2013-02-28', '06:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.560125+01', false, '');
INSERT INTO "Reservation" VALUES (3134, '2012-11-16', '08:00:00', true, 22, 300, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.089581+01', false, '');
INSERT INTO "Reservation" VALUES (3135, '2012-11-23', '08:00:00', true, 22, 300, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.092498+01', false, '');
INSERT INTO "Reservation" VALUES (3157, '2012-11-21', '07:00:00', true, 22, 300, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.724335+01', false, '');
INSERT INTO "Reservation" VALUES (3180, '2012-11-22', '06:00:00', true, 22, 300, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.397489+01', false, '');
INSERT INTO "Reservation" VALUES (3133, '2012-11-09', '08:00:00', true, 22, 300, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.086464+01', false, '');
INSERT INTO "Reservation" VALUES (3138, '2012-12-14', '08:00:00', true, 22, 300, true, NULL, NULL, 1171, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Freitag', '2012-11-02', '2013-04-10', '2012-11-03 11:21:26.101404+01', false, '');
INSERT INTO "Reservation" VALUES (3195, '2013-03-07', '06:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.564876+01', false, '');
INSERT INTO "Reservation" VALUES (3196, '2013-03-14', '06:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.569661+01', false, '');
INSERT INTO "Reservation" VALUES (3197, '2013-03-21', '06:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.573439+01', false, '');
INSERT INTO "Reservation" VALUES (3198, '2013-03-28', '06:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.586132+01', false, '');
INSERT INTO "Reservation" VALUES (3199, '2013-04-04', '06:00:00', false, 22, NULL, true, NULL, NULL, 1170, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Donnerstag', '2012-11-02', '2013-04-10', '2012-11-03 11:38:11.589094+01', false, '');
INSERT INTO "Reservation" VALUES (3200, '2012-11-07', '22:00:00', false, 22, 355, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.249807+01', false, '');
INSERT INTO "Reservation" VALUES (3201, '2012-11-14', '22:00:00', false, 22, 355, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.258891+01', false, '');
INSERT INTO "Reservation" VALUES (3203, '2012-11-28', '22:00:00', false, 22, 355, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.26803+01', false, '');
INSERT INTO "Reservation" VALUES (3204, '2012-12-05', '22:00:00', false, 22, 355, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.271528+01', false, '');
INSERT INTO "Reservation" VALUES (3205, '2012-12-12', '22:00:00', false, 22, 355, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.274739+01', false, '');
INSERT INTO "Reservation" VALUES (3206, '2012-12-19', '22:00:00', false, 22, 355, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.278125+01', false, '');
INSERT INTO "Reservation" VALUES (3207, '2012-12-26', '22:00:00', false, 22, 355, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.31497+01', false, '');
INSERT INTO "Reservation" VALUES (3208, '2013-01-02', '22:00:00', false, 22, NULL, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.333195+01', false, '');
INSERT INTO "Reservation" VALUES (3209, '2013-01-09', '22:00:00', false, 22, NULL, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.337949+01', false, '');
INSERT INTO "Reservation" VALUES (3210, '2013-01-16', '22:00:00', false, 22, NULL, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.374509+01', false, '');
INSERT INTO "Reservation" VALUES (3211, '2013-01-23', '22:00:00', false, 22, NULL, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.377834+01', false, '');
INSERT INTO "Reservation" VALUES (3212, '2013-01-30', '22:00:00', false, 22, NULL, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.385812+01', false, '');
INSERT INTO "Reservation" VALUES (3213, '2013-02-06', '22:00:00', false, 22, NULL, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.390042+01', false, '');
INSERT INTO "Reservation" VALUES (3214, '2013-02-13', '22:00:00', false, 22, NULL, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.393972+01', false, '');
INSERT INTO "Reservation" VALUES (3215, '2013-02-20', '22:00:00', false, 22, NULL, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.403852+01', false, '');
INSERT INTO "Reservation" VALUES (3216, '2013-02-27', '22:00:00', false, 22, NULL, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.410814+01', false, '');
INSERT INTO "Reservation" VALUES (2932, '2012-11-03', '20:00:00', false, 22, 6, false, NULL, NULL, 1132, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3217, '2013-03-06', '22:00:00', false, 22, NULL, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.415385+01', false, '');
INSERT INTO "Reservation" VALUES (3218, '2013-03-13', '22:00:00', false, 22, NULL, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.470059+01', false, '');
INSERT INTO "Reservation" VALUES (3219, '2013-03-20', '22:00:00', false, 22, NULL, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.480904+01', false, '');
INSERT INTO "Reservation" VALUES (3220, '2013-03-27', '22:00:00', false, 22, NULL, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.486223+01', false, '');
INSERT INTO "Reservation" VALUES (3221, '2013-04-03', '22:00:00', false, 22, NULL, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.490632+01', false, '');
INSERT INTO "Reservation" VALUES (3222, '2013-04-10', '22:00:00', false, 22, NULL, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.494368+01', false, '');
INSERT INTO "Reservation" VALUES (3223, '2012-11-06', '19:00:00', false, 22, 355, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.441872+01', false, '');
INSERT INTO "Reservation" VALUES (3224, '2012-11-13', '19:00:00', false, 22, 355, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.454431+01', false, '');
INSERT INTO "Reservation" VALUES (3226, '2012-11-27', '19:00:00', false, 22, 355, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.467484+01', false, '');
INSERT INTO "Reservation" VALUES (3227, '2012-12-04', '19:00:00', false, 22, 355, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.47066+01', false, '');
INSERT INTO "Reservation" VALUES (3228, '2012-12-11', '19:00:00', false, 22, 355, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.4741+01', false, '');
INSERT INTO "Reservation" VALUES (3229, '2012-12-18', '19:00:00', false, 22, 355, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.476866+01', false, '');
INSERT INTO "Reservation" VALUES (3230, '2012-12-25', '19:00:00', false, 22, 355, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.500468+01', false, '');
INSERT INTO "Reservation" VALUES (3231, '2013-01-01', '19:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.519595+01', false, '');
INSERT INTO "Reservation" VALUES (3232, '2013-01-08', '19:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.525177+01', false, '');
INSERT INTO "Reservation" VALUES (3233, '2013-01-15', '19:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.528904+01', false, '');
INSERT INTO "Reservation" VALUES (3234, '2013-01-22', '19:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.532224+01', false, '');
INSERT INTO "Reservation" VALUES (3235, '2013-01-29', '19:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.535368+01', false, '');
INSERT INTO "Reservation" VALUES (3236, '2013-02-05', '19:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.538219+01', false, '');
INSERT INTO "Reservation" VALUES (3237, '2013-02-12', '19:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.544045+01', false, '');
INSERT INTO "Reservation" VALUES (3238, '2013-02-19', '19:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.553354+01', false, '');
INSERT INTO "Reservation" VALUES (3239, '2013-02-26', '19:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.557001+01', false, '');
INSERT INTO "Reservation" VALUES (3240, '2013-03-05', '19:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.562591+01', false, '');
INSERT INTO "Reservation" VALUES (3241, '2013-03-12', '19:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.56647+01', false, '');
INSERT INTO "Reservation" VALUES (3242, '2013-03-19', '19:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.570162+01', false, '');
INSERT INTO "Reservation" VALUES (3243, '2013-03-26', '19:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.573579+01', false, '');
INSERT INTO "Reservation" VALUES (3244, '2013-04-02', '19:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.576788+01', false, '');
INSERT INTO "Reservation" VALUES (3245, '2013-04-09', '19:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.579386+01', false, '');
INSERT INTO "Reservation" VALUES (3246, '2012-11-07', '16:00:00', false, 22, 355, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.05717+01', false, '');
INSERT INTO "Reservation" VALUES (3249, '2012-11-28', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.078358+01', false, '');
INSERT INTO "Reservation" VALUES (3250, '2012-12-05', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.082057+01', false, '');
INSERT INTO "Reservation" VALUES (3251, '2012-12-12', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.088235+01', false, '');
INSERT INTO "Reservation" VALUES (3252, '2012-12-19', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.093592+01', false, '');
INSERT INTO "Reservation" VALUES (3253, '2012-12-26', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.116661+01', false, '');
INSERT INTO "Reservation" VALUES (3254, '2013-01-02', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.119787+01', false, '');
INSERT INTO "Reservation" VALUES (3255, '2013-01-09', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.122522+01', false, '');
INSERT INTO "Reservation" VALUES (3256, '2013-01-16', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.125068+01', false, '');
INSERT INTO "Reservation" VALUES (3257, '2013-01-23', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.127372+01', false, '');
INSERT INTO "Reservation" VALUES (3258, '2013-01-30', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.129691+01', false, '');
INSERT INTO "Reservation" VALUES (3259, '2013-02-06', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.136932+01', false, '');
INSERT INTO "Reservation" VALUES (3248, '2012-11-21', '16:00:00', true, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.074921+01', false, '');
INSERT INTO "Reservation" VALUES (3225, '2012-11-20', '19:00:00', true, 22, 355, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 11:46:34.458048+01', false, '');
INSERT INTO "Reservation" VALUES (3202, '2012-11-21', '22:00:00', true, 22, 355, true, NULL, NULL, 1174, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:42:04.263826+01', false, '');
INSERT INTO "Reservation" VALUES (3260, '2013-02-13', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.140241+01', false, '');
INSERT INTO "Reservation" VALUES (3261, '2013-02-20', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.143148+01', false, '');
INSERT INTO "Reservation" VALUES (3262, '2013-02-27', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.14684+01', false, '');
INSERT INTO "Reservation" VALUES (3263, '2013-03-06', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.150025+01', false, '');
INSERT INTO "Reservation" VALUES (3264, '2013-03-13', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.15264+01', false, '');
INSERT INTO "Reservation" VALUES (3265, '2013-03-20', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.157773+01', false, '');
INSERT INTO "Reservation" VALUES (3266, '2013-03-27', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.233858+01', false, '');
INSERT INTO "Reservation" VALUES (3267, '2013-04-03', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.237135+01', false, '');
INSERT INTO "Reservation" VALUES (3268, '2013-04-10', '16:00:00', false, 22, NULL, true, NULL, NULL, 1165, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:50:19.239732+01', false, '');
INSERT INTO "Reservation" VALUES (2673, '2011-12-04', '06:00:00', true, 22, -13, false, NULL, NULL, 1044, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2925, '2012-02-26', '12:00:00', false, 22, 13, false, NULL, NULL, 1121, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2927, '2012-02-25', '16:00:00', false, 22, 19, false, NULL, NULL, 1122, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2928, '2012-11-01', '15:00:00', false, 22, 13, false, NULL, NULL, 1131, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2929, '2012-11-01', '16:00:00', false, 22, 19, false, NULL, NULL, 1131, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2936, '2012-11-04', '13:00:00', true, 22, 1000000, false, NULL, NULL, 1132, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2855, '2012-01-15', '12:00:00', false, 22, 13, false, NULL, NULL, 1101, 86, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2787, '2012-01-08', '12:00:00', true, 22, 13, false, NULL, NULL, 1075, 84, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2906, '2012-01-15', '14:00:00', true, 22, 13, false, NULL, NULL, 1101, 86, 'hias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2908, '2012-01-29', '15:00:00', false, 22, 13, false, NULL, NULL, 1112, 42, 'Krisztina', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2907, '2012-01-29', '14:00:00', true, 22, 13, false, NULL, NULL, 1112, 42, 'Dr. Dirt', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2909, '2012-01-29', '17:00:00', false, 22, 19, false, NULL, NULL, 1112, 42, '1234567891', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2910, '2012-02-26', '13:00:00', false, 22, 13, false, NULL, NULL, 1114, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2911, '2012-02-26', '14:00:00', false, 22, 13, false, NULL, NULL, 1114, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2913, '2012-02-26', '15:00:00', false, 22, 13, false, NULL, NULL, 1114, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2916, '2012-02-26', '10:00:00', false, 22, 13, false, NULL, NULL, 1117, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2788, '2012-01-08', '12:00:00', true, 22, -13, false, NULL, NULL, 1076, 84, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2792, '2012-01-08', '11:00:00', true, 22, 13, false, NULL, NULL, 1080, 84, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2793, '2012-01-08', '11:00:00', true, 22, -13, false, NULL, NULL, 1081, 84, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2794, '2012-01-08', '19:00:00', true, 22, 19, false, NULL, NULL, 1083, 84, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2795, '2012-01-08', '19:00:00', true, 22, -19, false, NULL, NULL, 1084, 84, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2670, '2011-12-04', '06:00:00', true, 22, 13, true, NULL, NULL, 1042, 41, 'Mat', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2671, '2011-12-04', '07:00:00', true, 22, 13, true, NULL, NULL, 1042, 41, 'Mat', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2920, '2012-02-26', '09:00:00', false, 22, 13, false, NULL, NULL, 1119, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2737, '2011-12-26', '10:00:00', true, 22, NULL, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2736, '2011-12-19', '10:00:00', true, 22, 0, false, NULL, NULL, 1059, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2743, '2012-02-06', '10:00:00', false, 22, 0, false, NULL, NULL, 1059, 42, 'kkk', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2744, '2012-02-13', '10:00:00', false, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2745, '2012-02-20', '10:00:00', false, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2746, '2012-02-27', '10:00:00', false, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2747, '2012-03-05', '10:00:00', false, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2748, '2012-03-12', '10:00:00', false, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2735, '2011-12-12', '10:00:00', true, 22, 0, false, NULL, NULL, 1059, 42, 'XYZ', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2734, '2011-12-05', '10:00:00', true, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2728, '2011-10-24', '10:00:00', true, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2738, '2012-01-02', '10:00:00', true, 22, 0, false, NULL, NULL, 1059, 42, '123', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2733, '2011-11-28', '10:00:00', true, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2732, '2011-11-21', '10:00:00', true, 22, 0, false, NULL, NULL, 1059, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2740, '2012-01-16', '10:00:00', true, 22, 0, false, NULL, NULL, 1059, 42, '123', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2730, '2011-11-07', '10:00:00', true, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2739, '2012-01-09', '10:00:00', true, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2727, '2011-10-17', '10:00:00', true, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2741, '2012-01-23', '10:00:00', true, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2742, '2012-01-30', '10:00:00', true, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2749, '2012-03-19', '10:00:00', false, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2750, '2012-03-26', '10:00:00', false, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2751, '2012-04-02', '10:00:00', false, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2752, '2012-04-09', '10:00:00', false, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2731, '2011-11-14', '10:00:00', true, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2781, '2012-01-10', '06:00:00', true, 22, -13, false, NULL, NULL, 1066, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2786, '2012-01-03', '10:00:00', false, 22, 13, false, NULL, NULL, 1068, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2729, '2011-10-31', '10:00:00', true, 22, 0, false, NULL, NULL, 1059, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2726, '2011-12-04', '10:00:00', true, 22, 13, false, NULL, NULL, 1042, 42, '', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2672, '2011-12-04', '08:00:00', true, 22, 13, false, NULL, NULL, 1042, 42, 'Matthias Heindl', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2922, '2012-02-26', '06:00:00', false, 22, 13, false, NULL, NULL, 1120, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2918, '2012-02-26', '12:00:00', true, 22, 13, false, NULL, NULL, 1118, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2915, '2012-02-26', '11:00:00', true, 22, 13, false, NULL, NULL, 1115, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2938, '2012-11-03', '11:00:00', false, 22, 4, false, NULL, NULL, 1133, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2953, '2013-02-11', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2954, '2013-02-18', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2955, '2013-02-25', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2956, '2013-03-04', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2957, '2013-03-11', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2958, '2013-03-18', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2959, '2013-03-25', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2960, '2013-04-01', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2961, '2013-04-08', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2962, '2012-11-02', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2963, '2012-11-09', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2966, '2012-11-30', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2967, '2012-12-07', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2968, '2012-12-14', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2969, '2012-12-21', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2970, '2012-12-28', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2971, '2013-01-04', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2972, '2013-01-11', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2800, '2012-01-08', '18:00:00', false, 22, 19, false, NULL, NULL, 1088, 84, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2674, '2011-10-17', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2801, '2012-01-08', '19:00:00', false, 22, 19, false, NULL, NULL, 1088, 84, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2802, '2012-01-08', '20:00:00', true, 22, 19, false, NULL, NULL, 1088, 84, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2676, '2011-10-31', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2677, '2011-11-07', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2762, '2011-12-19', '15:00:00', true, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2763, '2011-12-26', '15:00:00', true, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2695, '2012-03-12', '06:00:00', false, 22, 0, false, NULL, NULL, 1044, 42, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2774, '2012-03-12', '15:00:00', false, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2696, '2012-03-19', '06:00:00', false, 22, 0, false, NULL, NULL, 1044, 42, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2775, '2012-03-19', '15:00:00', false, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2697, '2012-03-26', '06:00:00', false, 22, 0, false, NULL, NULL, 1044, 42, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2776, '2012-03-26', '15:00:00', false, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2680, '2011-11-28', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2758, '2011-11-21', '15:00:00', true, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2683, '2011-12-19', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2684, '2011-12-26', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2678, '2011-11-14', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2685, '2012-01-02', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2687, '2012-01-16', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2688, '2012-01-23', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2689, '2012-01-30', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2768, '2012-01-30', '15:00:00', false, 22, 0, true, NULL, NULL, 1062, 41, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2690, '2012-02-06', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2691, '2012-02-13', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2692, '2012-02-20', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2693, '2012-02-27', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2694, '2012-03-05', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2698, '2012-04-02', '06:00:00', false, 22, 0, false, NULL, NULL, 1044, 42, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2777, '2012-04-02', '15:00:00', false, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2699, '2012-04-09', '06:00:00', false, 22, 10, false, NULL, NULL, 1044, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2778, '2012-04-09', '15:00:00', false, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2964, '2012-11-16', '18:00:00', true, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2965, '2012-11-23', '18:00:00', true, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2754, '2011-10-24', '15:00:00', true, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2782, '2012-01-09', '06:00:00', true, 22, -13, false, NULL, NULL, 1066, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2757, '2011-11-14', '15:00:00', true, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2796, '2012-01-08', '21:00:00', true, 22, 19, false, NULL, NULL, 1082, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2797, '2012-01-08', '21:00:00', true, 22, -19, false, NULL, NULL, 1085, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2798, '2012-01-08', '21:00:00', false, 22, 19, false, NULL, NULL, 1085, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2799, '2012-01-08', '22:00:00', false, 22, 19, false, NULL, NULL, 1085, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2719, '2012-02-28', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2720, '2012-03-06', '06:00:00', false, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2852, '2012-01-15', '08:00:00', true, 22, 13, false, NULL, NULL, 1101, 86, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2710, '2011-12-27', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2853, '2012-01-15', '09:00:00', true, 22, 13, false, NULL, NULL, 1101, 86, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2854, '2012-01-15', '10:00:00', true, 22, 13, false, NULL, NULL, 1101, 86, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2702, '2011-11-01', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2703, '2011-11-08', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2712, '2012-01-10', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2851, '2012-01-15', '07:00:00', true, 22, 13, false, NULL, NULL, 1101, 86, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2790, '2012-01-08', '12:00:00', true, 22, -13, false, NULL, NULL, 1078, 84, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2791, '2012-01-08', '10:00:00', false, 22, 13, false, NULL, NULL, 1079, 84, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2912, '2012-02-26', '22:00:00', true, 22, 19, false, NULL, NULL, 1115, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2704, '2011-11-15', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2914, '2012-02-26', '21:00:00', false, 22, 19, false, NULL, NULL, 1116, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2917, '2012-02-26', '08:00:00', false, 22, 13, false, NULL, NULL, 1114, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2779, '2011-12-27', '06:00:00', true, 22, -13, false, NULL, NULL, 1063, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2780, '2011-12-26', '10:00:00', true, 22, -13, false, NULL, NULL, 1063, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2755, '2011-10-31', '15:00:00', true, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2681, '2011-12-05', '06:00:00', true, 22, 0, false, NULL, NULL, 1044, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2759, '2011-11-28', '15:00:00', true, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2803, '2012-01-08', '20:00:00', true, 22, -19, false, NULL, NULL, 1082, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2760, '2011-12-05', '15:00:00', true, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2761, '2011-12-12', '15:00:00', true, 22, 0, false, NULL, NULL, 1062, 42, '12345', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2682, '2011-12-12', '06:00:00', false, 22, 0, false, NULL, NULL, 1044, 42, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2764, '2012-01-02', '15:00:00', true, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2765, '2012-01-09', '15:00:00', true, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2766, '2012-01-16', '15:00:00', true, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2767, '2012-01-23', '15:00:00', true, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2769, '2012-02-06', '15:00:00', false, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2770, '2012-02-13', '15:00:00', false, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2771, '2012-02-20', '15:00:00', false, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2772, '2012-02-27', '15:00:00', false, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2919, '2012-02-26', '16:00:00', false, 22, 19, false, NULL, NULL, 1116, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2921, '2012-02-26', '07:00:00', false, 22, 13, false, NULL, NULL, 1115, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2706, '2011-11-29', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2773, '2012-03-05', '15:00:00', false, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2753, '2011-10-17', '15:00:00', true, 22, 0, false, NULL, NULL, 1062, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2707, '2011-12-06', '06:00:00', true, 22, 0, false, NULL, NULL, 1044, 42, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2708, '2011-12-13', '06:00:00', false, 22, 0, false, NULL, NULL, 1044, 42, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2725, '2012-04-10', '06:00:00', true, 22, 0, false, NULL, NULL, 1044, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2721, '2012-03-13', '06:00:00', false, 22, 0, false, NULL, NULL, 1044, 42, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2722, '2012-03-20', '06:00:00', false, 22, 0, false, NULL, NULL, 1044, 42, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2723, '2012-03-27', '06:00:00', false, 22, 0, false, NULL, NULL, 1044, 42, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2700, '2011-10-18', '06:00:00', true, 22, 0, true, NULL, NULL, 1044, 41, 'Test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2724, '2012-04-03', '06:00:00', false, 22, 0, false, NULL, NULL, 1044, 42, 'Matthias', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2783, '2012-01-03', '09:00:00', false, 22, 13, false, NULL, NULL, 1068, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2784, '2012-01-03', '10:00:00', true, 22, 13, false, NULL, NULL, 1068, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2785, '2012-01-03', '10:00:00', true, 22, -13, false, NULL, NULL, 1068, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2923, '2012-02-25', '14:00:00', false, 22, 13, false, NULL, NULL, 1117, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2924, '2012-02-25', '15:00:00', false, 22, 13, false, NULL, NULL, 1117, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2926, '2012-02-26', '11:00:00', false, 22, 13, false, NULL, NULL, 1114, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2930, '2012-11-02', '12:00:00', true, 22, 13, false, NULL, NULL, 1132, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2931, '2012-11-03', '19:00:00', false, 22, 6, false, NULL, NULL, 1132, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2933, '2012-11-02', '15:00:00', false, 22, 8, false, NULL, NULL, 1133, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2934, '2012-11-02', '16:00:00', false, 22, 10, false, NULL, NULL, 1133, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2935, '2012-11-02', '17:00:00', false, 22, 10, false, NULL, NULL, 1133, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2942, '2012-11-26', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2943, '2012-12-03', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2944, '2012-12-10', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2945, '2012-12-17', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2946, '2012-12-24', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2948, '2013-01-07', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2949, '2013-01-14', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2950, '2013-01-21', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2951, '2013-01-28', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2952, '2013-02-04', '06:00:00', false, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2974, '2013-01-25', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2975, '2013-02-01', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2976, '2013-02-08', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2977, '2013-02-15', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2978, '2013-02-22', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2979, '2013-03-01', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2980, '2013-03-08', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2981, '2013-03-15', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2982, '2013-03-22', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2983, '2013-03-29', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2984, '2013-04-05', '18:00:00', false, 22, NULL, true, NULL, NULL, 1141, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2940, '2012-11-12', '06:00:00', true, 22, 14, true, NULL, NULL, 1133, 41, 'Matthias1', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2941, '2012-11-19', '06:00:00', true, 22, NULL, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2988, '2012-11-28', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2989, '2012-12-05', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2990, '2012-12-12', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2992, '2012-12-26', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2993, '2013-01-02', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2994, '2013-01-09', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2995, '2013-01-16', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2996, '2013-01-23', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2997, '2013-01-30', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2998, '2013-02-06', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2999, '2013-02-13', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3000, '2013-02-20', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3001, '2013-02-27', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3002, '2013-03-06', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3003, '2013-03-13', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3004, '2013-03-20', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3005, '2013-03-27', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3006, '2013-04-03', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3007, '2013-04-10', '09:00:00', false, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3008, '2012-11-05', '17:00:00', false, 22, NULL, true, NULL, NULL, 1139, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3009, '2012-11-02', '21:00:00', false, 22, NULL, true, NULL, NULL, 1142, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3010, '2012-11-09', '21:00:00', false, 22, NULL, true, NULL, NULL, 1142, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3012, '2012-11-03', '21:00:00', false, 22, 10, false, NULL, NULL, 1149, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3013, '2012-11-03', '17:00:00', false, 22, 10, false, NULL, NULL, 1138, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3014, '2012-11-05', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3017, '2012-11-26', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3018, '2012-12-03', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3019, '2012-12-10', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3020, '2012-12-17', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3021, '2012-12-24', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3022, '2012-12-31', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3023, '2013-01-07', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3024, '2013-01-14', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3025, '2013-01-21', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3026, '2013-01-28', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3027, '2013-02-04', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3028, '2013-02-11', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3029, '2013-02-18', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3030, '2013-02-25', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3031, '2013-03-04', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3032, '2013-03-11', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3033, '2013-03-18', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3034, '2013-03-25', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3035, '2013-04-01', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3036, '2013-04-08', '16:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3042, '2012-12-10', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3043, '2012-12-17', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3044, '2012-12-24', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3046, '2013-01-07', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3047, '2013-01-14', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3048, '2013-01-21', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3049, '2013-01-28', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3050, '2013-02-04', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3051, '2013-02-11', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3052, '2013-02-18', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3053, '2013-02-25', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3054, '2013-03-04', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3055, '2013-03-11', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3056, '2013-03-18', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3057, '2013-03-25', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3058, '2013-04-01', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3059, '2013-04-08', '23:00:00', false, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3060, '2012-11-06', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3063, '2012-11-27', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3064, '2012-12-04', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3065, '2012-12-11', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3066, '2012-12-18', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3067, '2012-12-25', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3038, '2012-11-12', '23:00:00', true, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3039, '2012-11-19', '23:00:00', true, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2985, '2012-11-07', '09:00:00', true, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3061, '2012-11-13', '22:00:00', false, 22, 10, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3015, '2012-11-12', '16:00:00', true, 22, 10, true, NULL, NULL, 1163, 42, 'Krisztina', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3040, '2012-11-26', '23:00:00', true, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3041, '2012-12-03', '23:00:00', true, 22, NULL, true, NULL, NULL, 1164, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Montag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2991, '2012-12-19', '09:00:00', true, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3016, '2012-11-19', '16:00:00', true, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2987, '2012-11-21', '09:00:00', true, 22, NULL, true, NULL, NULL, 1146, 72, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3062, '2012-11-20', '22:00:00', true, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (2986, '2012-11-14', '09:00:00', true, 22, 12, true, NULL, NULL, 1146, 42, 'leer', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3068, '2013-01-01', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3069, '2013-01-08', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3070, '2013-01-15', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3071, '2013-01-22', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3072, '2013-01-29', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3073, '2013-02-05', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3074, '2013-02-12', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3075, '2013-02-19', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3076, '2013-02-26', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3077, '2013-03-05', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3078, '2013-03-12', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3079, '2013-03-19', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3080, '2013-03-26', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3081, '2013-04-02', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3082, '2013-04-09', '22:00:00', false, 22, NULL, true, NULL, NULL, 1163, 42, 'leer', 'Winter 2012/2013 ab 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3011, '2012-11-03', '13:00:00', true, 22, 10, false, NULL, NULL, 1149, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', false, '');
INSERT INTO "Reservation" VALUES (3327, '2012-11-06', '07:00:00', false, 22, 350, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.576725+01', false, '');
INSERT INTO "Reservation" VALUES (3330, '2012-11-27', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.597054+01', false, '');
INSERT INTO "Reservation" VALUES (3331, '2012-12-04', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.599954+01', false, '');
INSERT INTO "Reservation" VALUES (3332, '2012-12-11', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.60266+01', false, '');
INSERT INTO "Reservation" VALUES (3333, '2012-12-18', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.605165+01', false, '');
INSERT INTO "Reservation" VALUES (3334, '2012-12-25', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.607489+01', false, '');
INSERT INTO "Reservation" VALUES (3335, '2013-01-01', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.609833+01', false, '');
INSERT INTO "Reservation" VALUES (3336, '2013-01-08', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.61228+01', false, '');
INSERT INTO "Reservation" VALUES (3337, '2013-01-15', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.614996+01', false, '');
INSERT INTO "Reservation" VALUES (3338, '2013-01-22', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.648797+01', false, '');
INSERT INTO "Reservation" VALUES (3339, '2013-01-29', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.651278+01', false, '');
INSERT INTO "Reservation" VALUES (3340, '2013-02-05', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.653612+01', false, '');
INSERT INTO "Reservation" VALUES (3341, '2013-02-12', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.656093+01', false, '');
INSERT INTO "Reservation" VALUES (3342, '2013-02-19', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.65841+01', false, '');
INSERT INTO "Reservation" VALUES (3343, '2013-02-26', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.660729+01', false, '');
INSERT INTO "Reservation" VALUES (3344, '2013-03-05', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.663018+01', false, '');
INSERT INTO "Reservation" VALUES (3345, '2013-03-12', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.665558+01', false, '');
INSERT INTO "Reservation" VALUES (3346, '2013-03-19', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.668133+01', false, '');
INSERT INTO "Reservation" VALUES (3347, '2013-03-26', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.670624+01', false, '');
INSERT INTO "Reservation" VALUES (3348, '2013-04-02', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.672955+01', false, '');
INSERT INTO "Reservation" VALUES (3349, '2013-04-09', '07:00:00', false, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.675512+01', false, '');
INSERT INTO "Reservation" VALUES (3350, '2012-11-06', '08:00:00', false, 22, 9, false, NULL, NULL, 1188, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:37:22.641327+01', false, '');
INSERT INTO "Reservation" VALUES (3353, '2012-11-07', '12:00:00', true, 22, 8, false, NULL, NULL, 1190, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:42:24.125562+01', false, '');
INSERT INTO "Reservation" VALUES (3352, '2012-11-07', '09:00:00', true, 22, 8, false, NULL, NULL, 1189, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:42:11.293596+01', false, '');
INSERT INTO "Reservation" VALUES (3351, '2012-11-07', '08:00:00', true, 22, 9, false, NULL, NULL, 1188, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-04 15:37:22.646244+01', false, '');
INSERT INTO "Reservation" VALUES (3155, '2012-11-07', '07:00:00', true, 22, 300, true, NULL, NULL, 1173, 42, 'leer', 'Winter 2012/2013 bis 16:00', 'Mittwoch', '2012-11-02', '2013-04-10', '2012-11-03 11:35:15.674858+01', false, '');
INSERT INTO "Reservation" VALUES (3329, '2012-11-20', '07:00:00', true, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.594631+01', false, '');
INSERT INTO "Reservation" VALUES (3328, '2012-11-13', '07:00:00', true, 22, NULL, true, NULL, NULL, 1188, 41, 'leer', 'Winter 2012/2013 bis 16:00', 'Dienstag', '2012-11-02', '2013-04-10', '2012-11-04 15:36:51.591833+01', false, '');
INSERT INTO "Reservation" VALUES (3383, '2012-11-18', '19:00:00', false, 22, 11, false, NULL, NULL, 1240, 41, NULL, NULL, NULL, NULL, NULL, '2012-11-17 20:35:15.979601+01', false, '');
INSERT INTO "Reservation" VALUES (3390, '2012-11-18', '12:00:00', false, 22, 8, false, NULL, NULL, 1314, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-17 20:51:42.991419+01', false, '');
INSERT INTO "Reservation" VALUES (3395, '2012-11-23', '12:00:00', false, 22, 8, false, NULL, NULL, 1321, 42, NULL, NULL, NULL, NULL, NULL, '2012-11-24 15:46:06.274785+01', false, '');
INSERT INTO "Reservation" VALUES (3397, '2012-11-22', '12:00:00', false, 22, 8, false, NULL, NULL, 1323, 42, 'Testname', NULL, NULL, NULL, NULL, '2012-11-24 17:43:55.973851+01', false, '');
INSERT INTO "Reservation" VALUES (3396, '2012-11-24', '12:00:00', true, 22, 8, false, NULL, NULL, 1322, 42, 'Änderung', NULL, NULL, NULL, NULL, '2012-11-24 15:46:40.310634+01', false, '');
INSERT INTO "Reservation" VALUES (2947, '2012-12-31', '06:00:00', false, 22, 0, true, NULL, NULL, 1133, 42, 'test', NULL, NULL, NULL, NULL, '2012-11-03 16:23:24.123494+01', true, '');


--
-- Data for Name: Settings; Type: TABLE DATA; Schema: Roger; Owner: roger
--

INSERT INTO "Settings" VALUES (1, 'matthiasheindl@gmx.at', 1, 30, 0, '2013-11-20');


--
-- Data for Name: Tarife; Type: TABLE DATA; Schema: Roger; Owner: roger
--

INSERT INTO "Tarife" VALUES (1, 'A-Zeit', '16:00:00', '23:00:00', 10, 11, '2012-10-15', '2013-04-10');
INSERT INTO "Tarife" VALUES (2, 'B-Zeit', '06:00:00', '15:00:00', 8, 9, '2012-10-15', '2013-04-10');
INSERT INTO "Tarife" VALUES (4, 'Sommertarif', '06:00:00', '23:00:00', 10, 10, '2013-04-11', '2015-11-03');


SET search_path = public, pg_catalog;

--
-- Name: authorities_sequence; Type: SEQUENCE SET; Schema: public; Owner: roger
--

SELECT pg_catalog.setval('authorities_sequence', 176, true);


--
-- Name: court_sequence; Type: SEQUENCE SET; Schema: public; Owner: roger
--

SELECT pg_catalog.setval('court_sequence', 23, true);


--
-- Name: customer_sequence; Type: SEQUENCE SET; Schema: public; Owner: roger
--

SELECT pg_catalog.setval('customer_sequence', 124, true);


--
-- Name: invoice_sequence; Type: SEQUENCE SET; Schema: public; Owner: roger
--

SELECT pg_catalog.setval('invoice_sequence', 1331, true);


--
-- Name: reservation_sequence; Type: SEQUENCE SET; Schema: public; Owner: roger
--

SELECT pg_catalog.setval('reservation_sequence', 3406, true);


--
-- Name: saison_sequence; Type: SEQUENCE SET; Schema: public; Owner: roger
--

SELECT pg_catalog.setval('saison_sequence', 8, true);


--
-- Name: settings_sequence; Type: SEQUENCE SET; Schema: public; Owner: roger
--

SELECT pg_catalog.setval('settings_sequence', 1, true);


--
-- Name: zeiten_sequence; Type: SEQUENCE SET; Schema: public; Owner: roger
--

SELECT pg_catalog.setval('zeiten_sequence', 8, true);


SET search_path = "Roger", pg_catalog;

--
-- Name: Authorities_pkey; Type: CONSTRAINT; Schema: Roger; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Authorities"
    ADD CONSTRAINT "Authorities_pkey" PRIMARY KEY ("ID");


--
-- Name: Court_pkey; Type: CONSTRAINT; Schema: Roger; Owner: roger; Tablespace: 
--

ALTER TABLE ONLY "Court"
    ADD CONSTRAINT "Court_pkey" PRIMARY KEY ("CourtID");


--
-- Name: Customer_pkey; Type: CONSTRAINT; Schema: Roger; Owner: roger; Tablespace: 
--

ALTER TABLE ONLY "Customer"
    ADD CONSTRAINT "Customer_pkey" PRIMARY KEY ("CustomerID");


--
-- Name: ID_UNIQUE; Type: CONSTRAINT; Schema: Roger; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Authorities"
    ADD CONSTRAINT "ID_UNIQUE" UNIQUE ("ID");


--
-- Name: Invoice_pkey; Type: CONSTRAINT; Schema: Roger; Owner: roger; Tablespace: 
--

ALTER TABLE ONLY "Invoice"
    ADD CONSTRAINT "Invoice_pkey" PRIMARY KEY ("idInvoice");


--
-- Name: KundenID_UNIQUE; Type: CONSTRAINT; Schema: Roger; Owner: roger; Tablespace: 
--

ALTER TABLE ONLY "Customer"
    ADD CONSTRAINT "KundenID_UNIQUE" UNIQUE ("CustomerID");


--
-- Name: PlatzID_UNIQUE; Type: CONSTRAINT; Schema: Roger; Owner: roger; Tablespace: 
--

ALTER TABLE ONLY "Court"
    ADD CONSTRAINT "PlatzID_UNIQUE" UNIQUE ("CourtID");


--
-- Name: Reservation_pkey; Type: CONSTRAINT; Schema: Roger; Owner: roger; Tablespace: 
--

ALTER TABLE ONLY "Reservation"
    ADD CONSTRAINT "Reservation_pkey" PRIMARY KEY ("ReservationID");


--
-- Name: Reservierungsnummer_UNIQUE; Type: CONSTRAINT; Schema: Roger; Owner: roger; Tablespace: 
--

ALTER TABLE ONLY "Reservation"
    ADD CONSTRAINT "Reservierungsnummer_UNIQUE" UNIQUE ("ReservationID");


--
-- Name: Saison_pkey; Type: CONSTRAINT; Schema: Roger; Owner: roger; Tablespace: 
--

ALTER TABLE ONLY "Abo"
    ADD CONSTRAINT "Saison_pkey" PRIMARY KEY ("SaisonId");


--
-- Name: Settings_pkey; Type: CONSTRAINT; Schema: Roger; Owner: roger; Tablespace: 
--

ALTER TABLE ONLY "Settings"
    ADD CONSTRAINT "Settings_pkey" PRIMARY KEY ("settingsID");


--
-- Name: Zeiten_pkey; Type: CONSTRAINT; Schema: Roger; Owner: roger; Tablespace: 
--

ALTER TABLE ONLY "Tarife"
    ADD CONSTRAINT "Zeiten_pkey" PRIMARY KEY ("ZeitId");


--
-- Name: idInvoice_UNIQUE; Type: CONSTRAINT; Schema: Roger; Owner: roger; Tablespace: 
--

ALTER TABLE ONLY "Invoice"
    ADD CONSTRAINT "idInvoice_UNIQUE" UNIQUE ("idInvoice");


--
-- Name: settingsID_UNIQUE; Type: CONSTRAINT; Schema: Roger; Owner: roger; Tablespace: 
--

ALTER TABLE ONLY "Settings"
    ADD CONSTRAINT "settingsID_UNIQUE" UNIQUE ("settingsID");

SET search_path = public, pg_catalog;

SET search_path = "Roger", pg_catalog;

--
-- Name: fk_Invoice_Customer11; Type: INDEX; Schema: Roger; Owner: roger; Tablespace: 
--

CREATE INDEX "fk_Invoice_Customer11" ON "Invoice" USING btree ("Customer_CustomerID");


--
-- Name: fk_Reservation_Court1; Type: INDEX; Schema: Roger; Owner: roger; Tablespace: 
--

CREATE INDEX "fk_Reservation_Court1" ON "Reservation" USING btree ("Court_CourtID");


--
-- Name: fk_Reservation_Customer1; Type: INDEX; Schema: Roger; Owner: roger; Tablespace: 
--

CREATE INDEX "fk_Reservation_Customer1" ON "Reservation" USING btree ("Customer_CustomerID");


--
-- Name: fk_Reservation_Invoice1; Type: INDEX; Schema: Roger; Owner: roger; Tablespace: 
--

CREATE INDEX "fk_Reservation_Invoice1" ON "Reservation" USING btree ("Invoice_idInvoice");


--
-- Name: fk_Reservierung_Kunde1; Type: INDEX; Schema: Roger; Owner: roger; Tablespace: 
--

CREATE INDEX "fk_Reservierung_Kunde1" ON "Reservation" USING btree ("Kunde_KundenID");


--
-- Name: fk_Reservierung_Tennisplatz1; Type: INDEX; Schema: Roger; Owner: roger; Tablespace: 
--

CREATE INDEX "fk_Reservierung_Tennisplatz1" ON "Reservation" USING btree ("Tennisplatz_PlatzID");


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO roger;
GRANT ALL ON SCHEMA public TO PUBLIC;


SET search_path = public, pg_catalog;

--
-- Name: saison_sequence; Type: ACL; Schema: public; Owner: roger
--

REVOKE ALL ON SEQUENCE saison_sequence FROM PUBLIC;
REVOKE ALL ON SEQUENCE saison_sequence FROM roger;
GRANT ALL ON SEQUENCE saison_sequence TO roger;


SET search_path = "Roger", pg_catalog;

--
-- Name: Abo; Type: ACL; Schema: Roger; Owner: roger
--

REVOKE ALL ON TABLE "Abo" FROM PUBLIC;
REVOKE ALL ON TABLE "Abo" FROM roger;
GRANT ALL ON TABLE "Abo" TO roger;
GRANT ALL ON TABLE "Abo" TO PUBLIC;


SET search_path = public, pg_catalog;

--
-- Name: authorities_sequence; Type: ACL; Schema: public; Owner: roger
--

REVOKE ALL ON SEQUENCE authorities_sequence FROM PUBLIC;
REVOKE ALL ON SEQUENCE authorities_sequence FROM roger;
GRANT ALL ON SEQUENCE authorities_sequence TO roger;


SET search_path = "Roger", pg_catalog;

--
-- Name: Authorities; Type: ACL; Schema: Roger; Owner: postgres
--

REVOKE ALL ON TABLE "Authorities" FROM PUBLIC;
REVOKE ALL ON TABLE "Authorities" FROM postgres;
GRANT ALL ON TABLE "Authorities" TO postgres;
GRANT ALL ON TABLE "Authorities" TO PUBLIC;


SET search_path = public, pg_catalog;

--
-- Name: court_sequence; Type: ACL; Schema: public; Owner: roger
--

REVOKE ALL ON SEQUENCE court_sequence FROM PUBLIC;
REVOKE ALL ON SEQUENCE court_sequence FROM roger;
GRANT ALL ON SEQUENCE court_sequence TO roger;


SET search_path = "Roger", pg_catalog;

--
-- Name: Court; Type: ACL; Schema: Roger; Owner: roger
--

REVOKE ALL ON TABLE "Court" FROM PUBLIC;
REVOKE ALL ON TABLE "Court" FROM roger;
GRANT ALL ON TABLE "Court" TO roger;
GRANT ALL ON TABLE "Court" TO PUBLIC;


SET search_path = public, pg_catalog;

--
-- Name: customer_sequence; Type: ACL; Schema: public; Owner: roger
--

REVOKE ALL ON SEQUENCE customer_sequence FROM PUBLIC;
REVOKE ALL ON SEQUENCE customer_sequence FROM roger;
GRANT ALL ON SEQUENCE customer_sequence TO roger;


SET search_path = "Roger", pg_catalog;

--
-- Name: Customer; Type: ACL; Schema: Roger; Owner: roger
--

REVOKE ALL ON TABLE "Customer" FROM PUBLIC;
REVOKE ALL ON TABLE "Customer" FROM roger;
GRANT ALL ON TABLE "Customer" TO roger;
GRANT ALL ON TABLE "Customer" TO PUBLIC;


SET search_path = public, pg_catalog;

--
-- Name: invoice_sequence; Type: ACL; Schema: public; Owner: roger
--

REVOKE ALL ON SEQUENCE invoice_sequence FROM PUBLIC;
REVOKE ALL ON SEQUENCE invoice_sequence FROM roger;
GRANT ALL ON SEQUENCE invoice_sequence TO roger;


SET search_path = "Roger", pg_catalog;

--
-- Name: Invoice; Type: ACL; Schema: Roger; Owner: roger
--

REVOKE ALL ON TABLE "Invoice" FROM PUBLIC;
REVOKE ALL ON TABLE "Invoice" FROM roger;
GRANT ALL ON TABLE "Invoice" TO roger;
GRANT ALL ON TABLE "Invoice" TO PUBLIC;


SET search_path = public, pg_catalog;

--
-- Name: reservation_sequence; Type: ACL; Schema: public; Owner: roger
--

REVOKE ALL ON SEQUENCE reservation_sequence FROM PUBLIC;
REVOKE ALL ON SEQUENCE reservation_sequence FROM roger;
GRANT ALL ON SEQUENCE reservation_sequence TO roger;


SET search_path = "Roger", pg_catalog;

--
-- Name: Reservation; Type: ACL; Schema: Roger; Owner: roger
--

REVOKE ALL ON TABLE "Reservation" FROM PUBLIC;
REVOKE ALL ON TABLE "Reservation" FROM roger;
GRANT ALL ON TABLE "Reservation" TO roger;
GRANT ALL ON TABLE "Reservation" TO PUBLIC;


SET search_path = public, pg_catalog;

--
-- Name: settings_sequence; Type: ACL; Schema: public; Owner: roger
--

REVOKE ALL ON SEQUENCE settings_sequence FROM PUBLIC;
REVOKE ALL ON SEQUENCE settings_sequence FROM roger;
GRANT ALL ON SEQUENCE settings_sequence TO roger;


SET search_path = "Roger", pg_catalog;

--
-- Name: Settings; Type: ACL; Schema: Roger; Owner: roger
--

REVOKE ALL ON TABLE "Settings" FROM PUBLIC;
REVOKE ALL ON TABLE "Settings" FROM roger;
GRANT ALL ON TABLE "Settings" TO roger;
GRANT ALL ON TABLE "Settings" TO PUBLIC;


SET search_path = public, pg_catalog;

--
-- Name: zeiten_sequence; Type: ACL; Schema: public; Owner: roger
--

REVOKE ALL ON SEQUENCE zeiten_sequence FROM PUBLIC;
REVOKE ALL ON SEQUENCE zeiten_sequence FROM roger;
GRANT ALL ON SEQUENCE zeiten_sequence TO roger;


SET search_path = "Roger", pg_catalog;

--
-- Name: Tarife; Type: ACL; Schema: Roger; Owner: roger
--

REVOKE ALL ON TABLE "Tarife" FROM PUBLIC;
REVOKE ALL ON TABLE "Tarife" FROM roger;
GRANT ALL ON TABLE "Tarife" TO roger;
GRANT ALL ON TABLE "Tarife" TO PUBLIC;

SET search_path = public, pg_catalog;

--
-- PostgreSQL database dump complete
--

