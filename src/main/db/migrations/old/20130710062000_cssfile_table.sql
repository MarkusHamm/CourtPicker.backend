CREATE TABLE roger.cssfile
(
  id serial NOT NULL,
  cpinstanceid integer NOT NULL,
  content text,
  CONSTRAINT cssfile_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.cssfile OWNER TO roger;
