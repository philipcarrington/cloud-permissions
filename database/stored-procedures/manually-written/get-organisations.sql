drop procedure get_organisations
go
create procedure get_organisations()
    comment 'Create a temporary table called "get_organisations_tmp"'
begin
    drop table if exists get_organisations_tmp ;
    create temporary table get_organisations_tmp as
        select organisation_id,
               organisation_name,
               organisation_short_description
		from organisations;
end
go
-- Gotta run the proc to instantiate the temp table
call get_organisations()
      go -- produces a temporary table "tmpSomeData", exists for the session
-- Now it's usable
select * from get_organisations_tmp
go