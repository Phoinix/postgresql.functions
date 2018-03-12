CREATE OR REPLACE FUNCTION public.boolean_eq_integer (
  boolean,
  integer
)
RETURNS boolean AS
$body$
SELECT 
  CASE 
    WHEN $2 > 0 AND $1 IS TRUE THEN TRUE 
    WHEN $2 <= 0 AND $1 IS FALSE THEN TRUE 
    ELSE FALSE 
  END;
$body$
LANGUAGE 'sql'
IMMUTABLE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 3;

CREATE OPERATOR public.= ( PROCEDURE = public.boolean_eq_integer, 
LEFTARG = boolean, RIGHTARG = integer);
