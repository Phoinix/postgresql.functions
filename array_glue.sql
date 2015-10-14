CREATE OR REPLACE FUNCTION public.array_glue (
  inout arr pg_catalog.anyarray,
  item pg_catalog.anyelement = NULL::unknown
)
RETURNS pg_catalog.anyarray AS
$body$
BEGIN
    IF item IS NOT NULL AND item <> ALL (arr) THEN
        arr := array_append(arr, item);
    END IF;
    FOREACH item IN ARRAY arr LOOP
        arr := array_remove(arr, item);
        arr := array_append(arr, item);
    END LOOP;
    RETURN;
END;
$body$
LANGUAGE 'plpgsql'
IMMUTABLE
CALLED ON NULL INPUT
SECURITY INVOKER
LEAKPROOF
COST 100;

COMMENT ON FUNCTION public.array_glue(inout arr pg_catalog.anyarray, item pg_catalog.anyelement)
IS 'Glue array and remove doubles';