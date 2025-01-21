DO $$
DECLARE
    tbl RECORD;
BEGIN
    FOR tbl IN
        SELECT table_name
        FROM information_schema.columns
        WHERE column_name = 'id'
          AND table_schema = 'public'
    LOOP
        EXECUTE format(
            'DO $$
             BEGIN
                 IF EXISTS (SELECT 1 FROM information_schema.sequences WHERE sequence_name = ''%s_id_seq'') THEN
                     -- Nada a fazer se a sequência já existe
                     RAISE NOTICE ''Sequence already exists: %s_id_seq'';
                 ELSE
                     CREATE SEQUENCE %I_id_seq;
                 END IF;
                 ALTER TABLE %I ALTER COLUMN id DROP DEFAULT;
                 ALTER TABLE %I ALTER COLUMN id SET DEFAULT nextval(''%I_id_seq'');
             END $$;',
            tbl.table_name, tbl.table_name, tbl.table_name, tbl.table_name, tbl.table_name
        );
    END LOOP;
END $$;
