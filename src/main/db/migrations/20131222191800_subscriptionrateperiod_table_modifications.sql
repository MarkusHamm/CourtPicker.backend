-- subscription rate period
DROP TABLE roger.subscriptionrateperiod;

CREATE TABLE roger.subscriptionrateperiod
(
  id serial NOT NULL,
  courtcategoryid integer NOT NULL,
  name character varying(100),
  periodstart character varying(10),
  periodend character varying(10),
  price numeric,
  active boolean,
  ordernr integer,
  constraintime boolean,
  constrainweekday boolean,
  constainusergroup boolean,
  ctimefrom character varying(5),
  ctimeto character varying(5),
  cmon boolean,
  ctue boolean,
  cwed boolean,
  cthu boolean,
  cfri boolean,
  csat boolean,
  csun boolean,
  cusergroupids character varying(100),
  CONSTRAINT subscriptionrateperiod_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.subscriptionrateperiod OWNER TO roger;