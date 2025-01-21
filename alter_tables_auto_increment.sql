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
            -- Remove o valor padrão da coluna 'id'
            EXECUTE format(
                'ALTER TABLE %I ALTER COLUMN id DROP DEFAULT;',
                tbl.table_name
            );

            -- Adiciona a propriedade de identidade à coluna 'id'
            EXECUTE format(
                'ALTER TABLE %I ALTER COLUMN id SET GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1);',
                tbl.table_name
            );

        EXCEPTION
            WHEN others THEN
                RAISE NOTICE 'Erro ao processar tabela: %', tbl.table_name;
        END;
    END LOOP;
END $$;
