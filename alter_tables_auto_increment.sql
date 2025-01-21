DO $$ 
DECLARE
    row RECORD;
BEGIN
    FOR row IN 
        SELECT table_name
        FROM information_schema.columns
        WHERE table_schema = 'public'
        AND column_default IS NULL
        AND column_name = 'id'
        AND table_name NOT IN (
            SELECT table_name
            FROM information_schema.columns
            WHERE column_default LIKE 'nextval%'
        )
    LOOP
        -- Primeiro remove o DEFAULT, se houver
        EXECUTE 'ALTER TABLE ' || row.table_name || ' ALTER COLUMN id DROP DEFAULT';

        -- Agora, adiciona a configuração GENERATED ALWAYS AS IDENTITY
        EXECUTE 'ALTER TABLE ' || row.table_name || ' ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1)';
    END LOOP;
END $$;
