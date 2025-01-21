DO $$ 
DECLARE
    r RECORD;
BEGIN
    -- Para cada tabela que tem uma coluna 'id'
    FOR r IN 
        SELECT table_name, column_name 
        FROM information_schema.columns 
        WHERE column_name = 'id' AND table_schema = 'public'
    LOOP
        -- Alterar a coluna 'id' para GENERATED ALWAYS AS IDENTITY
        EXECUTE format('ALTER TABLE public.%I ALTER COLUMN %I SET GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1)', r.table_name, r.column_name);
    END LOOP;
END $$;
