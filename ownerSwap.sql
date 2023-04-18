SELECT set_config('var.newOwner', :'owner', FALSE);

do
$$
declare
	newOwner TEXT;
	rec record;
begin
	newOwner := current_setting('var.newOwner');
		execute 'ALTER TYPE varchar OWNER TO '||newOwner||';';
		execute 'ALTER TYPE bool OWNER TO '||newOwner||';';
		execute 'ALTER TYPE text OWNER TO '||newOwner||';';
		execute 'ALTER TYPE timestamp OWNER TO '||newOwner||';';
	--Schemas
	for rec in(select 'alter schema '||nspname||' owner to '||newOwner||';' as query from pg_namespace)
	loop
		execute rec.query;
	end loop;
	--Tables
	for rec in(SELECT 'ALTER TABLE '|| schemaname || '."' || tablename ||'" OWNER TO '||newOwner||';' as query FROM pg_tables WHERE NOT schemaname IN ('pg_catalog', 'information_schema'))
	loop
		execute rec.query;
	end loop;
	--Sequences
	for rec in(SELECT 'ALTER SEQUENCE '|| sequence_schema || '."' || sequence_name ||'" OWNER TO '||newOwner||';' as query FROM information_schema.sequences WHERE NOT sequence_schema IN ('pg_catalog', 'information_schema'))
	loop
		execute rec.query;
	end loop;
	--Views
	for rec in(SELECT 'ALTER VIEW '|| table_schema || '."' || table_name ||'" OWNER TO '||newOwner||';' as query FROM information_schema.views WHERE NOT table_schema IN ('pg_catalog', 'information_schema'))
	loop
		execute rec.query;
	end loop;
	--Materialized views
	for rec in(SELECT 'ALTER TABLE '|| oid::regclass::text ||' OWNER TO '||newOwner||';' as query FROM pg_class WHERE relkind = 'm')
	loop
		execute rec.query;
	end loop;
	--Functions
	for rec in(SELECT 'ALTER FUNCTION '||n.nspname||'."'||p.proname||'"('||pg_catalog.pg_get_function_identity_arguments(p.oid)||') OWNER TO '||newOwner||';' as query
		FROM pg_catalog.pg_proc p
		JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace
		where n.nspname NOT IN ('pg_catalog', 'information_schema') AND p.prokind IN ('f', 'a', 'w'))
	loop
		execute rec.query;
	end loop;
	--Procedures
	for rec in(SELECT 'ALTER PROCEDURE '||n.nspname||'."'||p.proname||'"('||pg_catalog.pg_get_function_identity_arguments(p.oid)||') OWNER TO '||newOwner||';' as query
		FROM pg_catalog.pg_proc p
		JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace
		where n.nspname NOT IN ('pg_catalog', 'information_schema') AND p.prokind = 'p')
	loop
		execute rec.query;
	end loop;
end$$;
