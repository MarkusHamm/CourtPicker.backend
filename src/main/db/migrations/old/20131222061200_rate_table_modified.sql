DROP TABLE roger.rate;

-- rate
CREATE TABLE roger.rate
(
  id serial NOT NULL,
  courtcategoryid integer NOT NULL,
  name character varying(100),
  price numeric,
  constraindate boolean,
  constraintime boolean,
  constrainweekday boolean,
  constrainusergroup boolean,
  cdatefrom character varying(6),
  cdateto character varying(6),
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
  ordernr integer,
  active boolean,
  CONSTRAINT rate_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.rate OWNER TO roger;
