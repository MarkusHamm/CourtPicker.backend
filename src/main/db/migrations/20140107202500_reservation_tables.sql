-- reservation table
CREATE TABLE roger.singlereservation
(
  id serial NOT NULL,
  customerid integer not null,
  courtid integer not null,
  fromdt timestamp with time zone not null,
  todt timestamp with time zone not null,
  reservationdt timestamp with time zone not null,
  reservingcustomerid integer not null,
  displayname character varying(80) default '',
  ispaid boolean default false,
  isdeleted boolean default false,
  price numeric,
  comment character varying(80) default '',
  CONSTRAINT singlereservation_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.singlereservation OWNER TO roger;

-- subscriptionreservation table
CREATE TABLE roger.subscriptionperiodreservation
(
  id serial NOT NULL,
  customerid integer not null,
  courtid integer not null,
  periodstart date,
  periodend date,
  fromtime time with time zone not null,
  totime time with time zone not null,
  interval character varying(45) not null,
  reservationdt timestamp with time zone not null,
  reservingcustomerid integer not null,
  displayname character varying(80) default '',
  ispaid boolean default false,
  isdeleted boolean default false,
  price numeric,
  comment character varying(80) default '',
  CONSTRAINT subscriptionperiodreservation_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.subscriptionperiodreservation OWNER TO roger;
