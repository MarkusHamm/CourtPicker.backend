ALTER TABLE roger.court ADD COLUMN deleted boolean default false;
ALTER TABLE roger.courtcategory ADD COLUMN deleted boolean default false;
ALTER TABLE roger.subscription ADD COLUMN deleted boolean default false;
ALTER TABLE roger.usergroup ADD COLUMN deleted boolean default false;