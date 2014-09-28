-- subscription
CREATE TABLE roger.subscription
(
  id serial NOT NULL,
  courtcategoryid integer NOT NULL,
  name character varying(100),
  periodstart date,
  periodend date,
  bookablefrom date,
  bookableto date,
  ordernr integer,
  CONSTRAINT subscription_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.subscription OWNER TO roger;

-- subscription rate
CREATE TABLE roger.subscriptionrate
(
  id serial NOT NULL,
  subscriptionid integer NOT NULL,
  name character varying(100),
  price numeric,
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
  CONSTRAINT subscriptionrate_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.subscriptionrate OWNER TO roger;

-- subscription reservation
CREATE TABLE roger.subscriptionreservation
(
  id serial NOT NULL,
  customerid integer not null,
  courtid integer not null,
  periodstart date,
  periodend date,
  fromtime time with time zone not null,
  totime time with time zone not null,
  reservationdate timestamp with time zone not null,
  reservingcustomerid integer not null,
  displayname character varying(80) default '',
  paid boolean default false,
  deleted boolean default false,
  price numeric,
  comment character varying(80) default '',
  customername character varying(100) DEFAULT NULL::character varying,
  calculatedprice numeric,
  paymentdate timestamp with time zone,
  paymentoptionid integer,
  CONSTRAINT subscriptionreservation_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.subscriptionreservation OWNER TO roger;
