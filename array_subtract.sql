CREATE OR REPLACE FUNCTION public.array_subtract (
  inout left_array pg_catalog.anyarray,
  right_array pg_catalog.anyarray = NULL::anyarray
)
RETURNS pg_catalog.anyarray AS
$body$
DECLARE
    counter     INTEGER DEFAULT 1;
BEGIN
    IF right_array IS NULL THEN
        RETURN;
    END IF;
    counter := array_length(right_array, 1);
    WHILE counter > 0 LOOP
        left_array := array_remove(left_array, right_array[counter]);
        counter := counter - 1;
    END LOOP;
    RETURN;
END;
$body$
LANGUAGE 'plpgsql'
IMMUTABLE
CALLED ON NULL INPUT
LEAKPROOF
COST 10;

COMMENT ON FUNCTION public.array_subtract(inout left_array pg_catalog.anyarray, right_array pg_catalog.anyarray)
IS 'Subtract second array from first';