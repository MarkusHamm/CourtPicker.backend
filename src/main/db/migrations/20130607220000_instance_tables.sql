-- Table: roger.cpinstance

-- DROP TABLE roger.cpinstance;

CREATE TABLE roger.cpinstance
(
  id serial NOT NULL,
  name character varying(80),
  licence character varying(50),
  CONSTRAINT cpinstance_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.cpinstance OWNER TO roger;

-- Table: roger.courtcategory

-- DROP TABLE roger.courtcategory;

CREATE TABLE roger.courtcategory
(
  id serial NOT NULL,
  cpinstanceid integer NOT NULL,
  name character varying(50),
  ordernr integer,
  CONSTRAINT courtcategory_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.courtcategory OWNER TO roger;
