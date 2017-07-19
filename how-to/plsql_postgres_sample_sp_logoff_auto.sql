-- Function: sp_logoff_auto()

-- DROP FUNCTION sp_logoff_auto();

CREATE OR REPLACE FUNCTION sp_logoff_auto()
  RETURNS void AS
$BODY$  declare  
    r requisicao%rowtype;
begin
         for r in select *
	from requisicao
	where ((current_timestamp - tslogin) >= interval '24 hours') and (tslogoff is null) loop
	update requisicao set tslogoff = to_timestamp('01 jan 3000', 'dd mon yyyy') where id = r.id;
      end loop;	

end;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sp_logoff_auto()
  OWNER TO postgres;