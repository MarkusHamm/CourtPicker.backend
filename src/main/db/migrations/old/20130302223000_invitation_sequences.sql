-- CREATE Message sequence
CREATE SEQUENCE message_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	
ALTER TABLE public.message_sequence OWNER TO roger;
GRANT ALL ON SEQUENCE message_sequence TO roger;

-- CREATE Invitees sequence
CREATE SEQUENCE invitees_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	
ALTER TABLE public.invitees_sequence OWNER TO roger;
GRANT ALL ON SEQUENCE invitees_sequence TO roger;

-- CREATE Invitation sequence
CREATE SEQUENCE invitation_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	
ALTER TABLE public.invitation_sequence OWNER TO roger;
GRANT ALL ON SEQUENCE invitation_sequence TO roger;
