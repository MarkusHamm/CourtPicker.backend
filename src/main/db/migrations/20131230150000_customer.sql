-- customer table
CREATE TABLE roger.customer
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
  UNIQUE(username)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE roger.customer OWNER TO roger;
