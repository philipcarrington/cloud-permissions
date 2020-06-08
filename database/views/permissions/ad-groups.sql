with authorised_groups_base_data as (
        select distinct odtdd.o_organisation_name as primary_identifier,
                        odtdd.d_department_name as seconday_identifier,
                        odtdd.t_team_name as tertiary_identifier,
                        'team' as dataset_prefix,
                        odtdd.o_organisation_identifier as organisation_identifier,
                        odtdd.d_department_name as dataset_name_pt1,
                        odtdd.t_team_name as dataset_name_pt2,
                        odtdd.o_organisation_email_domain as organisation_email_domain                                   
        from permissions_meta.organisation_department_team_datasets_denorm odtdd
        union all
        select distinct gdd.g_group_name as primary_identifier,
                       null as seconday_identifier,
                       null as tertiary_identifier,
                       gdd.g_group_prefix as dataset_prefix,
                       odted.o_organisation_identifier as organisation_identifier,
                       gdd.g_group_name as dataset_name_pt1,
                       null as dataset_name_pt2,
                       odted.o_organisation_email_domain as organisation_email_domain          
        from permissions_meta.group_datasets_denorm gdd
            inner join permissions_meta.employee_groups eg 
                on gdd.g_group_id = eg.group_id
            inner join permissions_meta.organisation_department_team_employees_denorm odted
                on eg.employee_id = odted.e_employee_id
        union all
        select distinct jdd.j_job_name as primary_identifier,
                       null as seconday_identifier,
                       null as tertiary_identifier,
                       'job' as  dataset_prefix,
                       odted.o_organisation_identifier as organisation_identifier,
                       jdd.j_job_name as dataset_name_pt1,
                       null as dataset_name_pt2,
                       odted.o_organisation_email_domain as organisation_email_domain  
        from permissions_meta.job_datasets_denorm jdd
            inner join permissions_meta.employee_jobs ej
                on jdd.j_job_id = ej.job_id
            inner join permissions_meta.organisation_department_team_employees_denorm odted
                on ej.employee_id = odted.e_employee_id
        union all
        select distinct sadd.gcsa_google_cloud_service_account_name as primary_identifier,
                       null as seconday_identifier,
                       null as tertiary_identifier,
                       'sa' as  dataset_prefix,
                       odtgsa.o_organisation_identifier  as organisation_identifier,
                       sadd.gcsa_google_cloud_service_account_name as dataset_name_pt1,
                       null as dataset_name_pt2,
                       odtgsa.o_organisation_email_domain       
        from permissions_meta.service_account_datasets_denorm sadd
            inner join permissions_meta.organisation_department_team_google_service_accounts_denorm odtgsa
    ),
    authorised_groups_data as (
        select base.primary_identifier,
               base.seconday_identifier,
               base.tertiary_identifier,
               concat(
                        base.dataset_prefix, '-',
                        base.organisation_identifier, '-'                                                                  
               ) as authorised_group_name_start,
               replace(
                       lower(
                               case when (base.dataset_name_pt2 is not null) then 
                                    concat(base.dataset_name_pt1, '-', base.dataset_name_pt2)
                               else
                                   base.dataset_name_pt1
                               end 
                            ),
                       ' ',
                       '-'
                       )                             
                        as authorised_group_name_end,
               base.organisation_email_domain
        from  authorised_groups_base_data as base              
    ),
    authorised_group_names as (
        select agd.primary_identifier,
               agd.seconday_identifier,
               agd.tertiary_identifier,
               concat(
                        agd.authorised_group_name_start,
                        agd.authorised_group_name_end
                     ) as authorised_group_name,
               agd.organisation_email_domain
        from authorised_groups_data agd
    )
select agn.primary_identifier,
       agn.seconday_identifier,
       agn.tertiary_identifier,
       agn.authorised_group_name as authorisation_service_group_name,
       concat(agn.authorised_group_name, '@', agn.organisation_email_domain) as authorisation_service_group_name_email
from authorised_group_names agn    