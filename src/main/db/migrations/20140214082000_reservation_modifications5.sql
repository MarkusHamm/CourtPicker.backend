ALTER TABLE roger.singlereservation ALTER COLUMN customerid DROP NOT NULL;
ALTER TABLE roger.singlereservation ADD COLUMN customername character varying(100) DEFAULT NULL;
ALTER TABLE roger.singlereservation ADD COLUMN calculatedprice numeric;
