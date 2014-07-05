ALTER TABLE roger.subscriptionreservation ADD COLUMN subscriptionid integer not null default -1;
ALTER TABLE roger.subscriptionreservation ALTER COLUMN subscriptionid drop default;
