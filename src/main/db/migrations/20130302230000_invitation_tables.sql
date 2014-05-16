-- ALTER Settings table
ALTER TABLE "Roger"."Settings" ADD COLUMN "invitationModuleEnabled" boolean default false;

-- CREATE Message table
CREATE TABLE "Roger"."Message"
(
  "id" integer NOT NULL DEFAULT nextval('message_sequence'::regclass),
  "customerReference" integer NOT NULL,
  "invitationReference" integer NOT NULL,
  "reservationReference" integer NOT NULL,
  "text" character varying(1000),
  "isRead" boolean NOT NULL,
  "FirstName" character varying(100),
  "LastName" character varying(100),
  "dt_inserted" timestamp with time zone NOT NULL,
  CONSTRAINT "Message_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "Message_UNIQUE" UNIQUE ("id")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Roger"."Message"
  OWNER TO roger;
GRANT ALL ON TABLE "Roger"."Message" TO roger;
GRANT ALL ON TABLE "Roger"."Message" TO public;

-- CREATE Invitees table
CREATE TABLE "Roger"."Invitees"
(
  "id" integer NOT NULL DEFAULT nextval('invitees_sequence'::regclass),
  "invitationReference" integer NOT NULL,
  "customerReference" integer NOT NULL,
  "FirstName" character varying(100),
  "LastName" character varying(100),
  "participates" boolean NOT NULL default false,
  CONSTRAINT "Invitee_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "Invitee_UNIQUE" UNIQUE ("id")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Roger"."Invitees"
  OWNER TO roger;
GRANT ALL ON TABLE "Roger"."Invitees" TO roger;
GRANT ALL ON TABLE "Roger"."Invitees" TO public;

-- CREATE Invitation table
CREATE TABLE "Roger"."Invitation"
(
  "id" integer NOT NULL DEFAULT nextval('invitation_sequence'::regclass),
  "reservationId" integer NOT NULL,
  "participantLimit" integer NOT NULL,
  "inviter" integer NOT NULL,
  CONSTRAINT "Invitation_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "Invitation_UNIQUE" UNIQUE ("id")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Roger"."Invitation"
  OWNER TO roger;
GRANT ALL ON TABLE "Roger"."Invitation" TO roger;
GRANT ALL ON TABLE "Roger"."Invitation" TO public;
