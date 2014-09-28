CREATE TABLE roger.webdesign
(
  id serial NOT NULL,
  cpinstanceid integer NOT NULL,
  backgroundstyle character varying(50),
  backgroundcolor character varying(50),
  headercolor character varying(50),
  headerbackgroundcolor character varying(50),
  buttoncolor character varying(50),
  CONSTRAINT webdesign_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.webdesign OWNER TO roger;