-- rate
CREATE TABLE roger.rate
(
  id serial NOT NULL,
  courtcategoryid integer NOT NULL,
  name character varying(100),
  price numeric,
  active boolean,
  datefrom date,
  dateto date,
  timefrom time,
  timeto time,
  weekdays character varying(70),
  usergroupids character varying(100),
  ordernr integer,
  CONSTRAINT rate_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.rate OWNER TO roger;

-- subscription rate quantity
CREATE TABLE roger.subscriptionratequantity
(
  id serial NOT NULL,
  courtcategoryid integer NOT NULL,
  name character varying(100),
  quantity integer,
  price numeric,
  active boolean,
  datefrom date,
  dateto date,
  timefrom time,
  timeto time,
  weekdays character varying(70),
  usergroups character varying(100),
  ordernr integer,
  CONSTRAINT subscriptionratequantity_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.subscriptionratequantity OWNER TO roger;

-- subscription rate period
CREATE TABLE roger.subscriptionrateperiod
(
  id serial NOT NULL,
  courtcategoryid integer NOT NULL,
  name character varying(100),
  periodstart date,
  periodend date,
  price numeric,
  active boolean,
  datefrom date,
  dateto date,
  timefrom time,
  timeto time,
  weekdays character varying(70),
  usergroups character varying(100),
  ordernr integer,
  CONSTRAINT subscriptionrateperiod_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.subscriptionrateperiod OWNER TO roger;