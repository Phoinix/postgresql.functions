CREATE OR REPLACE FUNCTION public.array_equal (
  pg_catalog.anyarray = '{}'::integer[],
  pg_catalog.anyarray = '{}'::integer[]
)
RETURNS boolean AS
$body$
SELECT 
    CASE 
        WHEN $1 <@ $2 AND $1 @> $2 
        THEN TRUE 
        ELSE 
            CASE 
                WHEN $1 IS NULL AND $2 IS NULL 
                THEN TRUE 
                ELSE FALSE 
            END 
    END;
$body$
LANGUAGE 'sql'
IMMUTABLE
CALLED ON NULL INPUT
LEAKPROOF
COST 2;

COMMENT ON FUNCTION public.array_equal(pg_catalog.anyarray, pg_catalog.anyarray)
IS 'Equal two array ignoring element order';

CREATE OPERATOR public.>< ( PROCEDURE = public.array_equal, LEFTARG = anyarray, RIGHTARG = anyarray);

COMMENT ON OPERATOR public.>< (anyarray, anyarray)
IS 'Operator for function array_equal';