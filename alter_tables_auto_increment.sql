DO $$
DECLARE
    tbl RECORD;
    col RECORD;
BEGIN
    -- Loop pelas tabelas com coluna 'id'
    FOR tbl IN
        SELECT table_name
        FROM information_schema.columns
        WHERE column_name = 'id'
          AND table_schema = 'public'
    LOOP
        BEGIN
            -- Verificar se a coluna 'id' já é do tipo 'IDENTITY'
            FOR col IN
                SELECT column_name
                FROM information_schema.columns
                WHERE table_name = tbl.table_name
                  AND column_name = 'id'
                  AND is_identity = 'YES'
            LOOP
                -- Se a coluna já for identidade, não fazemos nada
                RAISE NOTICE 'Coluna id em % já é do tipo IDENTITY. Nenhuma alteração necessária.', tbl.table_name;
                RETURN;
            END LOOP;

            -- Remover o valor padrão da coluna 'id', se presente
            EXECUTE format(
                'ALTER TABLE %I ALTER COLUMN id DROP DEFAULT;',
                tbl.table_name
            );

            -- Alterar a coluna 'id' para 'IDENTITY' (iniciando com 1 e incrementando por 1)
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
