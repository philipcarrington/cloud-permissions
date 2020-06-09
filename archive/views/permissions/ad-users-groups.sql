with authorised_users_to_groups_base_data as (
        select distinct odted.e_given_name as user_given_name,
                        odted.e_family_name as user_family_name,
                        odted.o_organisation_name as primary_identifier,
                        odted.d_department_name as seconday_identifier,
                        odted.t_team_name as tertiary_identifier,
                        'team' as dataset_prefix,
                        odted.o_organisation_identifier as organisation_identifier,
                        odted.d_department_name as dataset_name_pt1,
                        odted.t_team_name as dataset_name_pt2,
                        odted.o_organisation_email_domain as organisation_email_domain
        from permissions_meta.organisation_department_team_employees_denorm odted
        union all
        select distinct egd.e_given_name as user_given_name,
                       egd.e_family_name as user_family_name,       
                       egd.g_group_name as primary_identifier,
                       null as seconday_identifier,
                       null as tertiary_identifier,
                       egd.g_group_prefix as dataset_prefix,
                       odted.o_organisation_identifier as organisation_identifier,
                       egd.g_group_name as dataset_name_pt1,
                       null as dataset_name_pt2,
                       odted.o_organisation_email_domain as organisation_email_domain    
        from permissions_meta.employee_groups_denorm egd
            inner join permissions_meta.employee_groups eg 
                on egd.g_group_id = eg.group_id
            inner join permissions_meta.organisation_department_team_employees_denorm odted
                on eg.employee_id = odted.e_employee_id
        union all
        select distinct ejd.e_given_name as user_given_name,
                       ejd.e_family_name as user_family_name,  
                       ejd.j_job_name as primary_identifier,
                       null as seconday_identifier,
                       null as tertiary_identifier,
                       'job' as  dataset_prefix,
                       odted.o_organisation_identifier as organisation_identifier,
                       ejd.j_job_name as dataset_name_pt1,
                       null as dataset_name_pt2,
                       odted.o_organisation_email_domain as organisation_email_domain  
        from permissions_meta.employee_jobs_denorm ejd
            inner join permissions_meta.organisation_department_team_employees_denorm odted
                on ejd.e_employee_id = odted.e_employee_id                                
    ),
    authorised_users_to_groups_data as (
        select base.user_given_name,
               base.user_family_name,
               base.primary_identifier,
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
        from authorised_users_to_groups_base_data as base              
    ),
    authorised_users_to_groups_names as (
        select agd.user_given_name,
               agd.user_family_name,
               agd.primary_identifier,
               agd.seconday_identifier,
               agd.tertiary_identifier,
               concat(
                        agd.authorised_group_name_start,
                        agd.authorised_group_name_end
                     ) as authorised_group_name,
               agd.organisation_email_domain
        from authorised_users_to_groups_data agd
    )
select agn.user_given_name,
       agn.user_family_name,               
       agn.primary_identifier,
       agn.seconday_identifier,
       agn.tertiary_identifier,
       concat(
                lower(agn.user_given_name), '.',
                lower(agn.user_family_name), '@', 
                agn.organisation_email_domain
             ) as user_email_identifier,
       agn.authorised_group_name as authorisation_service_group_name,
       concat(agn.authorised_group_name, '@', agn.organisation_email_domain) as authorisation_service_group_name_email
from authorised_users_to_groups_names agn                        




/*
-- Service accounts would not go into AD?

select odtgsad.gcsa_google_cloud_service_account_name,
       odtgsad.gcsa_google_cloud_service_account_name as primary_identifier,
       null as seconday_identifier,
       null as tertiary_identifier,
       'sa' as  dataset_prefix,
       odtgsad.o_organisation_identifier  as organisation_identifier,
       odtgsad.gcsa_google_cloud_service_account_name as dataset_name_pt1,
       null as dataset_name_pt2,
       odtgsad.o_organisation_email_domain       
from permissions_meta.organisation_department_team_google_service_accounts_denorm odtgsad            
*/            