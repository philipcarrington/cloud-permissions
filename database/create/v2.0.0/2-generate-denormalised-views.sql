--------------------------------------------------------------------------------
-- !! Not all my own work !!
-- No point in reinventing the wheel; adjustments made though
-- Found here: https://stackoverflow.com/questions/8672815/mysql-extract-first-letter-of-each-word-in-a-specific-column
-------------------------------------------------------------------------------

set global log_bin_trust_function_creators = 1
go

drop function if exists `initials`
go
create function `initials`(str varchar(64), expr varchar(64)) RETURNS varchar(64) CHARSET utf8
begin
    declare result varchar(64) default '';
    declare buffer varchar(64) default '';
    declare i int default 1;
    if(str is null) then
        return null;
    end if;
    set buffer = trim(str);
    while i <= length(buffer) do
        if substr(buffer, i, 1) regexp expr then
            set result = concat( result, substr( buffer, i, 1 ));
            set i = i + 1;
            while i <= length( buffer ) and substr(buffer, i, 1) regexp expr do
                set i = i + 1;
            end while;
            while i <= length( buffer ) and substr(buffer, i, 1) not regexp expr do
                set i = i + 1;
            end while;
        else
            set i = i + 1;
        end if;
    end while;
    return result;
end
go


drop function if exists `acronym`
go
CREATE FUNCTION `acronym`(str varchar(64)) RETURNS varchar(64) CHARSET utf8
begin
    declare result varchar(64) default '';
    set result = initials( str, '[[:alnum:]]' );
    return result;
end
go

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Create a table to hold a load of meta about the tables:
drop table permissions_meta.denormalise_tables_data
go
create table permissions_meta.denormalise_tables_data (
    table_no                    int,
    table_schema                varchar(255),
    table_name                  varchar(255),
    table_acronym               varchar(10),
    table_aliased_columns       varchar(1000)
)
go

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Populate the table:
set @row_number:=0
go

insert into permissions_meta.denormalise_tables_data
with
    tables_with_acronyms as (
        select @row_number:=@row_number + 1 as table_no,
               rel_table_base.table_schema,
               rel_table_base.table_name,
               rel_table_base.table_acronym
        from (
            select kcu.table_schema,
                   kcu.table_name,
                   acronym(kcu.table_name) as table_acronym
            from information_schema.key_column_usage kcu
            where kcu.constraint_schema = 'permissions_meta'
                and ((kcu.constraint_name like 'fk_%') or (kcu.constraint_name like 'REL%'))
            union
            select kcu.referenced_table_schema,
                   kcu.referenced_table_name,
                   acronym(kcu.referenced_table_name) as table_acronym
            from information_schema.key_column_usage kcu
            where kcu.constraint_schema = 'permissions_meta'
                and ((kcu.constraint_name like 'fk_%') or (kcu.constraint_name like 'REL%'))
          ) as rel_table_base
    )
select twa.table_no,
       twa.table_schema,
       twa.table_name,
       twa.table_acronym,
       group_concat(
                    concat('\t', twa.table_acronym, '_', twa.table_no, '.', isc.column_name, ' as ', twa.table_acronym, '_', isc.column_name)
                    separator ', \n '
       ) as table_aliased_columns
from information_schema.columns isc
    inner join tables_with_acronyms twa
        on isc.table_schema = twa.table_schema
            and isc.table_name = twa.table_name
group by twa.table_no,
       twa.table_schema,
       twa.table_name,
       twa.table_acronym
go       


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- See what we have got:
select *
from permissions_meta.denormalise_tables_data
go
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Create a table to hold all the data:
drop table permissions_meta.denormalized_view_data
go

create table permissions_meta.denormalized_view_data (
    orig_table_no               int,
    orig_table_schema           varchar(255),
    orig_table_name             varchar(255),
    orig_table_alias            varchar(10),
    level_no                    int,
    cur_table_no                int,
    cur_table_schema            varchar(255),
    cur_table_name              varchar(255),
    cur_table_alias             varchar(10),
    cur_join_column_name        varchar(255),
    cur_table_columns           varchar(1000),
    ref_table_no                int,
    ref_table_schema            varchar(255),
    ref_table_name              varchar(255),
    ref_table_alias             varchar(10),
    ref_join_column_name        varchar(255),
    ref_table_columns           varchar(1000)
)
go

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Populate the table:
insert into permissions_meta.denormalized_view_data
with recursive table_hirearchy as (
    select c_dtd.table_no as orig_table_no,
           c_dtd.table_schema as orig_table_schema,
           c_dtd.table_name as orig_table_name,
           c_dtd.table_acronym as orig_table_alias,
           1 as level_no,
           c_dtd.table_no as cur_table_no,
           c_dtd.table_schema as cur_table_schema,
           c_dtd.table_name as cur_table_name,
           c_dtd.table_acronym as cur_table_alias,
           kcu.referenced_column_name as cur_join_column_name,
           c_dtd.table_aliased_columns as cur_table_columns,
           r_dtd.table_no as ref_table_no,
           r_dtd.table_schema as ref_table_schema,
           r_dtd.table_name as ref_table_name,
           r_dtd.table_acronym as ref_table_alias,
           kcu.referenced_column_name as ref_join_column_name,
           r_dtd.table_aliased_columns as ref_table_columns
    from information_schema.key_column_usage kcu
        inner join permissions_meta.denormalise_tables_data c_dtd
            on kcu.table_schema = c_dtd.table_schema
                and kcu.table_name = c_dtd.table_name
        inner join permissions_meta.denormalise_tables_data r_dtd
            on kcu.referenced_table_schema = r_dtd.table_schema
                and kcu.referenced_table_name = r_dtd.table_name
    -- For testing an individual view:
    -- where c_dtd.table_schema = 'permissions_meta'
    --    and kcu.table_name = 'organisation_department_team_datasets'
    union all
    select th.orig_table_no,
           th.orig_table_schema,
           th.orig_table_name,
           th.orig_table_alias,
           1 + th.level_no as level_no,
           th.ref_table_no as cur_table_no,
           th.ref_table_schema as cur_table_schema,
           th.ref_table_name as cur_table_name,
           th.ref_table_alias as cur_table_alias,
           kcu2.referenced_column_name as cur_join_column_name,
           --th.ref_join_column_name as cur_join_column_name,
           th.ref_table_columns as cur_table_columns,
           r_dtd.table_no as ref_table_no,
           r_dtd.table_schema as ref_table_schema,
           r_dtd.table_name as ref_table_name,
           r_dtd.table_acronym as ref_table_alias,
           kcu2.referenced_column_name as ref_join_column_name,
           r_dtd.table_aliased_columns as ref_table_columns
    from table_hirearchy th
        inner join information_schema.key_column_usage kcu2
            on th.ref_table_schema = kcu2.table_schema
                and th.ref_table_name = kcu2.table_name
        inner join permissions_meta.denormalise_tables_data r_dtd
            on kcu2.referenced_table_schema = r_dtd.table_schema
                and kcu2.referenced_table_name = r_dtd.table_name
)
select distinct *
from table_hirearchy
go
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- See what we have got:
select *
from permissions_meta.denormalized_view_data
go

select dvd.level_no,
       dvd.cur_table_no,
       dvd.cur_table_name,
       dvd.cur_join_column_name,
       dvd.ref_table_no,
       dvd.ref_table_name,
       dvd.ref_join_column_name,
       dvd.orig_table_no,
       dvd.orig_table_name
from permissions_meta.denormalized_view_data dvd
where dvd.orig_table_no = 18
go


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- See what is in the table:
set session group_concat_max_len = 1000000
go

with
    create_view_const as (
        select distinct
            dvd.orig_table_no,
            -- Edit this to create in a different schema:
            coalesce(null, dvd.orig_table_schema) as view_schema,
            -- Edit thiis to give it a different view name:
            coalesce(null, dvd.orig_table_name) as view_main_name,
            -- Edit this to change the suffix to the view:
            coalesce(null, '_denorm') as view_main_suffix,
            -- Edit this for the statement sep
            coalesce(null, '\n go \n') as statement_sep
        from permissions_meta.denormalized_view_data dvd
         -- For testing:
         where orig_table_schema = 'permissions_meta'
            -- and orig_table_name = '<your-table-name>'
    ),
    view_drop as (
        select
            distinct dvd.orig_table_no,
            concat(
            'drop view ',
            -- Edit this to create in a different schema:
            cvc.view_schema, '.',
            -- Edit thiis to give it a different view name:
            cvc.view_main_name,
            -- Edit this to change the suffix to the view:
            cvc.view_main_suffix, cvc.statement_sep
        ) as drop_view_line
        from permissions_meta.denormalized_view_data dvd
            inner join create_view_const cvc
                on dvd.orig_table_no = cvc.orig_table_no
         -- For testing:
         where orig_table_schema = 'permissions_meta'
            -- and orig_table_name = '<your-table-name>'
    ),
    view_create as (
        select distinct dvd.orig_table_no,
            concat(
            'create view ',
            -- Edit this to create in a different schema:
            cvc.view_schema, '.',
            -- Edit thiis to give it a different view name:
            cvc.view_main_name,
            -- Edit this to change the suffix to the view:
            cvc.view_main_suffix, ' as ('
        ) as create_view_line_start,
        concat('\n)', cvc.statement_sep) as create_view_line_end
        from permissions_meta.denormalized_view_data dvd
            inner join create_view_const cvc
                on dvd.orig_table_no = cvc.orig_table_no
         -- For testing:
         where orig_table_schema = 'permissions_meta'
            -- and orig_table_name = '<your-table-name>'
    ),
    view_columns as (
         select cols_base.orig_table_no,
                concat('select \n',
                        group_concat(cols_base.table_columns)
                      ) as columns_section
         from (
                 select dvd.orig_table_no,
                        dvd.cur_table_columns as table_columns
                 from permissions_meta.denormalized_view_data dvd
                 -- For testing:
                 where orig_table_schema = 'permissions_meta'
                    -- and orig_table_name = '<your-table-name>'
                 union distinct
                 select dvd.orig_table_no,
                        dvd.ref_table_columns as table_columns
                 from permissions_meta.denormalized_view_data dvd
                 -- For testing:
                 where orig_table_schema = 'permissions_meta'
                    -- and orig_table_name = '<your-table-name>'
                ) as cols_base
         group by  cols_base.orig_table_no
    ),
    view_from as (
        select distinct
               dvd.orig_table_no,
               concat(
                    'from ', dvd.orig_table_schema, '.', dvd.orig_table_name, ' as ', dvd.orig_table_alias, '_', dvd.orig_table_no
               ) as from_section
        from permissions_meta.denormalized_view_data dvd
        -- For testing:
        where orig_table_schema = 'permissions_meta'
          --  and orig_table_name = '<your-table-name>'
    ),
    view_joins as (
        select dvd.orig_table_no,
               dvd.level_no,
               concat (
                    'inner join ', dvd.ref_table_schema, '.', dvd.ref_table_name, ' as ', dvd.ref_table_alias, '_', dvd.ref_table_no, '\n',
                    '\t on ', dvd.cur_table_alias, '_', dvd.cur_table_no, '.', dvd.ref_join_column_name, ' = ',  dvd.ref_table_alias, '_', dvd.ref_table_no, '.', dvd.ref_join_column_name
               ) as joins_section
        from permissions_meta.denormalized_view_data dvd
        -- For testing:
        where orig_table_schema = 'permissions_meta'
           -- and orig_table_name = '<your-table-name>'
    )
select  vd.drop_view_line,
        concat(
            vcr.create_view_line_start, '\n',
            vc.columns_section, '\n',
            vf.from_section, '\n\t',
            group_concat(
                vj.joins_section
                order by vj.level_no
                separator '\n\t'

            ),
            vcr.create_view_line_end
       ) as view_code
from view_create vcr
    inner join view_drop vd
        on vcr.orig_table_no = vd.orig_table_no
    inner join view_columns vc
        on vcr.orig_table_no = vc.orig_table_no
    inner join view_from vf
        on vcr.orig_table_no = vf.orig_table_no
    left join view_joins vj
        on vcr.orig_table_no = vj.orig_table_no
group by vd.drop_view_line,
         vcr.create_view_line_start,
         vc.columns_section,
         vf.from_section,
         vcr.create_view_line_end
go
