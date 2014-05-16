-- rate
CREATE TABLE roger.court
(
  id serial NOT NULL,
  courtcategoryid integer NOT NULL,
  name character varying(50),
  ordernr integer,
  CONSTRAINT court_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.court OWNER TO roger;
