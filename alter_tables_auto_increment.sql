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
            -- Verifica se a coluna id já é uma coluna de identidade antes de tentar alterar
            IF NOT EXISTS (
                SELECT 1
                FROM information_schema.columns
                WHERE table_schema = 'public'
                  AND table_name = tbl.table_name
                  AND column_name = 'id'
                  AND is_identity = 'YES'
            ) THEN
                EXECUTE format(
                    'ALTER TABLE %I ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1);',
                    tbl.table_name
                );
            END IF;
        EXCEPTION
            WHEN others THEN
                RAISE NOTICE 'Erro ao processar tabela: %', tbl.table_name;
        END;
    END LOOP;
END $$;
