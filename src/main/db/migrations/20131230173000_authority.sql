-- authority table
CREATE TABLE roger.authority
(
  id serial NOT NULL,
  userid integer,
  cpinstanceid integer,
  authority character varying(45),
  CONSTRAINT authority_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.authority OWNER TO roger;
