CREATE TABLE cp.authority
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
ALTER TABLE cp.authority
  OWNER TO cpuser;
  
CREATE TABLE cp.court
(
  id serial NOT NULL,
  courtcategoryid integer NOT NULL,
  name character varying(50),
  ordernr integer,
  deleted boolean DEFAULT false,
  CONSTRAINT court_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cp.court
  OWNER TO cpuser;
  
CREATE TABLE cp.courtcategory
(
  id serial NOT NULL,
  cpinstanceid integer NOT NULL,
  name character varying(50),
  ordernr integer,
  bookablefromtime character varying(5),
  bookabletotime character varying(5),
  bookingunit integer,
  deleted boolean DEFAULT false,
  CONSTRAINT courtcategory_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cp.courtcategory
  OWNER TO cpuser;
  
CREATE TABLE cp.cpinstance
(
  id serial NOT NULL,
  name character varying(80),
  licence character varying(50),
  shortname character varying(50),
  licencestartdate date,
  CONSTRAINT cpinstance_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cp.cpinstance
  OWNER TO cpuser;
  
CREATE TABLE cp.cssfile
(
  id serial NOT NULL,
  cpinstanceid integer NOT NULL,
  content text,
  CONSTRAINT cssfile_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cp.cssfile
  OWNER TO cpuser;
  
CREATE TABLE cp.customer
(
  id serial NOT NULL,
  username character varying(45),
  password character varying,
  enabled boolean NOT NULL,
  firstname character varying(30),
  lastname character varying(45),
  email character varying(60),
  activationcode character varying(45),
  street character varying(45),
  zipcode character varying(45),
  city character varying(45),
  country character varying(45),
  birthday date,
  handynumber character varying(45),
  phonenumber character varying(45),
  CONSTRAINT customer_pkey PRIMARY KEY (id),
  CONSTRAINT customer_username_key UNIQUE (username)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cp.customer
  OWNER TO cpuser;
  
CREATE TABLE cp.customer_usergroup
(
  id serial NOT NULL,
  customerid integer NOT NULL,
  usergroupid integer NOT NULL,
  CONSTRAINT customer_usergroup_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cp.customer_usergroup
  OWNER TO cpuser;
  
CREATE TABLE cp.paymentoption
(
  id serial NOT NULL,
  name character varying(50) NOT NULL,
  active boolean DEFAULT true,
  cpinstanceid integer NOT NULL,
  deleted boolean DEFAULT false,
  CONSTRAINT paymentoption_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cp.paymentoption
  OWNER TO cpuser;
  
CREATE TABLE cp.singlerate
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
ALTER TABLE cp.singlerate
  OWNER TO cpuser;
  
CREATE TABLE cp.singlereservation
(
  id serial NOT NULL,
  customerid integer,
  courtid integer NOT NULL,
  fromdate timestamp with time zone NOT NULL,
  todate timestamp with time zone NOT NULL,
  reservationdate timestamp with time zone NOT NULL,
  reservingcustomerid integer NOT NULL,
  displayname character varying(80) DEFAULT ''::character varying,
  paid boolean DEFAULT false,
  deleted boolean DEFAULT false,
  price numeric,
  comment character varying(80) DEFAULT ''::character varying,
  customername character varying(100) DEFAULT NULL::character varying,
  calculatedprice numeric,
  paymentdate timestamp with time zone,
  paymentoptionid integer,
  CONSTRAINT singlereservation_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cp.singlereservation
  OWNER TO cpuser;

CREATE TABLE cp.subscription
(
  id serial NOT NULL,
  courtcategoryid integer NOT NULL,
  name character varying(100),
  periodstart character varying(10),
  periodend character varying(10),
  bookablefrom character varying(10),
  bookableto character varying(10),
  ordernr integer,
  deleted boolean DEFAULT false,
  CONSTRAINT subscription_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cp.subscription
  OWNER TO cpuser;
    
CREATE TABLE cp.subscriptionrate
(
  id serial NOT NULL,
  subscriptionid integer NOT NULL,
  name character varying(100),
  price numeric,
  constraintime boolean,
  constrainweekday boolean,
  constrainusergroup boolean,
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
ALTER TABLE cp.subscriptionrate
  OWNER TO cpuser;

CREATE TABLE cp.subscriptionreservation
(
  id serial NOT NULL,
  customerid integer,
  courtid integer NOT NULL,
  periodstart character varying(10),
  periodend character varying(10),
  fromtime character varying(5) NOT NULL,
  totime character varying(5) NOT NULL,
  reservationdate timestamp with time zone NOT NULL,
  reservingcustomerid integer NOT NULL,
  displayname character varying(80) DEFAULT ''::character varying,
  paid boolean DEFAULT false,
  deleted boolean DEFAULT false,
  price numeric,
  comment character varying(80) DEFAULT ''::character varying,
  customername character varying(100) DEFAULT NULL::character varying,
  calculatedprice numeric,
  paymentdate timestamp with time zone,
  paymentoptionid integer,
  subscriptionid integer NOT NULL,
  CONSTRAINT subscriptionreservation_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cp.subscriptionreservation
  OWNER TO cpuser;

CREATE TABLE cp.usergroup
(
  id serial NOT NULL,
  cpinstanceid integer NOT NULL,
  name character varying(100),
  deleted boolean DEFAULT false,
  CONSTRAINT usergroup_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cp.usergroup
  OWNER TO cpuser;
  
CREATE TABLE cp.webdesign
(
  id serial NOT NULL,
  cpinstanceid integer NOT NULL,
  backgroundstyle character varying(50),
  backgroundcolor character varying(50),
  headercolor character varying(50),
  headerbackgroundcolor character varying(50),
  controlscolor character varying(50),
  contentcolor character varying(50),
  contentbackgroundcolor character varying(50),
  ctselectcolor character varying(50),
  ctselectbackgroundcolor character varying(50),
  ctselectfocuscolor character varying(50),
  linkcolor character varying(50),
  reservablehourcolor character varying(50),
  nonreservablehourcolor character varying(50),
  footercolor character varying(50),
  controlstextcolor character varying(50) DEFAULT ''::character varying,
  CONSTRAINT webdesign_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cp.webdesign
  OWNER TO cpuser;
  
CREATE TABLE cp.webdesignfile
(
  id serial NOT NULL,
  webdesignid integer NOT NULL,
  type character varying(20),
  content bytea,
  CONSTRAINT webdesignfile_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cp.webdesignfile
  OWNER TO cpuser;
