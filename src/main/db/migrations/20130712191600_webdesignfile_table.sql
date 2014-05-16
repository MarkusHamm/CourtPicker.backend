CREATE TABLE roger.webdesignfile
(
  id serial NOT NULL,
  webdesignid integer NOT NULL,
  type character varying(20),
  content bytea,
  CONSTRAINT webdesignfile_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.webdesignfile OWNER TO roger;
