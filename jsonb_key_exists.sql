CREATE OR REPLACE FUNCTION public.jsonb_key_exists (
  jsonb,
  text
)
RETURNS boolean AS
$body$
SELECT $1 ? $2
$body$
LANGUAGE 'sql'
IMMUTABLE
COST 5;

CREATE OPERATOR public.%> ( PROCEDURE = public.jsonb_key_exists, 
LEFTARG = jsonb, RIGHTARG = text);
