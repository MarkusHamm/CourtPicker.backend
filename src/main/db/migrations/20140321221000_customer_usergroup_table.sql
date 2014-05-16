-- rate
CREATE TABLE roger.customer_usergroup
(
  id serial NOT NULL,
  customerid integer NOT NULL,
  usergroupid integer NOT NULL,
  CONSTRAINT customer_usergroup_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.customer_usergroup OWNER TO roger;
