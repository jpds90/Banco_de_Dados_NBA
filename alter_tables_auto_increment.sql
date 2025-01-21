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
        BEGIN
            -- Tenta executar o comando apenas se a coluna id não for identidade
            EXECUTE format(
                'DO $$ BEGIN
                    IF NOT EXISTS (
                        SELECT 1
                        FROM information_schema.columns
                        WHERE table_schema = ''public''
                          AND table_name = ''%I''
                          AND column_name = ''id''
                          AND is_identity = ''YES''
                    ) THEN
                        ALTER TABLE %I ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1);
                    END IF;
                END $$;',
                tbl.table_name, tbl.table_name
            );
        EXCEPTION
            WHEN others THEN
                RAISE NOTICE 'Skipped table: %', tbl.table_name;
        END;
    END LOOP;
END $$;
