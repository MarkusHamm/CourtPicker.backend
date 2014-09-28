-- paymentoption table
CREATE TABLE roger.paymentoption
(
  id serial NOT NULL,
  name character varying(50) NOT NULL,
  active boolean default true,
  CONSTRAINT paymentoption_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

-- modify singlereservation table
ALTER TABLE roger.singlereservation ADD COLUMN paydate timestamp with time zone default NULL;
ALTER TABLE roger.singlereservation ADD COLUMN paymentoptionid integer default NULL;

