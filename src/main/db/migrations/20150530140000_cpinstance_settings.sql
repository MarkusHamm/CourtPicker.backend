alter table cp.cpinstance add column mailatregistration boolean default false;
alter table cp.cpinstance add column reservationlimit integer default -1;
alter table cp.cpinstance add column reservationlabelvisibility character varying(50) default 'ADMIN';
