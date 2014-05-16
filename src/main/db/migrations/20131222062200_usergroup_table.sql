-- usergroup
CREATE TABLE roger.usergroup
(
  id serial NOT NULL,
  cpinstanceid integer NOT NULL,
  name character varying(100),
  CONSTRAINT usergroup_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.usergroup OWNER TO roger;
