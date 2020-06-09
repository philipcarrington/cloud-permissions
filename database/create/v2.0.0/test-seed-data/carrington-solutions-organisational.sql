--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Populate the tables with some data:
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Organisations:

INSERT INTO organisations(
    -- organisation_id, 
    organisation_name, 
    organisation_short_description, 
    organisation_identifier, 
    organisation_email_domain
) 
VALUES(
   -- 0,
   'Carrington Solutions UK', 
   'My Company', 
   'csuk', 
   'dangerousdba.com'
)
GO

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Departments:

INSERT INTO departments(
    -- department_id, 
    department_name, 
    department_short_desc
) 
VALUES
    ('Data','Data herders and breeders'),
    ('Web','Make the button blue'),
    ('IT','Turn it off and on again')
GO



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Teams:

INSERT INTO teams(
    -- team_id, 
    team_name, 
    team_short_description
) 
VALUES
    ('Data Products','Data herders and breeders'),
    ('Data Science','Clever people'),
    ('Data Foundations','Build the blocks to be stiched together'),
    ('Web UI UX','Really making the button Blue or green'),
    ('IT Helpdesks','Taking the call')    
GO

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Organisation Department Teams:
select *
from organisation_department_teams
go
select *
from teams t, organisations o, departments d
go
INSERT INTO organisation_department_teams(
    -- organisation_department_team_id, 
    organisation_id, 
    department_id, 
    team_id, 
    organisation_department_team_short_description
) 
select o.organisation_id,
       d.department_id,
       t.team_id,
       concat(d.department_short_desc, ' - ', t.team_short_description)             
from teams t, organisations o, departments d
where left(t.team_name, length(d.department_name)) = d.department_name
GO

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Jobs:
INSERT INTO jobs(
    -- job_id, 
    job_name, 
    job_short_description
) 
VALUES
    ('Junior Data Engineer', ''),
    ('Data Engineer', ''),
    ('Senior Data Engineer', ''),
    ('Junior Web Engineer', ''),
    ('Web Engineer', ''),
    ('Senior Web Engineer', ''),
    ('Junior Data Scientist', ''),
    ('Data Scientist', ''),
    ('Senior Data Scientist', ''),
    ('Junior Helpdesk', ''),
    ('Data Helpdesk', ''),
    ('Senior Data Helpdesk', '')     
GO


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Groups:
--delete from `groups`
INSERT INTO `groups`(
    -- group_id, 
    group_name, 
    group_short_description, 
    group_prefix, 
    group_suffix
) 
VALUES
    ('Senior', '', 'tech', NULL),
    ('Admin', '', 'admin', NULL)
GO

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Employees:


INSERT INTO employees(
    -- employee_id, 
    given_name, 
    family_name
) 
VALUES
    ('Philip', 'Carrington'),
    ('Christopher', 'Kenbright'),
    ('Sharon', 'Wosbee'),
    ('James', 'Smithers'),
    ('Rosie', 'Jones')
GO

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Google Cloud Service Accounts:


INSERT INTO google_cloud_service_accounts(
    -- google_cloud_service_account_id, 
    google_cloud_service_account_email, 
    google_cloud_service_account_name, 
    google_cloud_service_account_status, 
    google_cloud_service_account_description
) 
VALUES
    ('test-595@philc-permissions-meta.iam.gserviceaccount.com', 'permissions Test Account', 1, 'Testing Stuff out')
GO

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Organisation Department Team service accounts:


INSERT INTO organisation_department_team_google_service_accounts(
    -- organisation_department_team_google_service_account_id, 
    organisation_department_team_id, 
    google_cloud_service_account_id
)
select odt.organisation_department_team_id,
       gcsa.google_cloud_service_account_id
from organisation_department_teams odt, google_cloud_service_accounts gcsa
where odt.organisation_department_team_id = 1

go



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Organisation Department Team Jobs:
select *
from organisation_department_teams odt, employees e
go
select *
from organisation_department_team_employees
go

INSERT INTO organisation_department_team_employees(
    -- organisation_department_team_employee_id,
    organisation_department_team_id,
    employee_id
)
select odt.organisation_department_team_id,
       e.employee_id
from organisation_department_teams odt, employees e
where ((e.employee_id = 1) and (odt.organisation_department_team_id = 1))
    or ((e.employee_id = 2) and (odt.organisation_department_team_id = 2))
    or ((e.employee_id = 3) and (odt.organisation_department_team_id = 5))
    or ((e.employee_id = 4) and (odt.organisation_department_team_id = 1))
    or ((e.employee_id = 5) and (odt.organisation_department_team_id = 4))
go


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Employee Jobs:
select *
from jobs j, employees e
go
select *
from employee_jobs
go
INSERT INTO employee_jobs(
    -- employee_job_id,
    employee_id,
    job_id
)
select e.employee_id,
       j.job_id
from jobs j, employees e
where (j.job_name = 'Senior Data Engineer' and concat(e.given_name, e.family_name) = 'PhilipCarrington')
    or (j.job_name = 'Data Scientist' and concat(e.given_name, e.family_name) = 'ChristopherKenbright')
    or (j.job_name = 'Data Engineer' and concat(e.given_name, e.family_name) = 'JamesSmithers')
    or (j.job_name = 'Web Engineer' and concat(e.given_name, e.family_name) = 'RosieJones')
    or (j.job_name = 'Data Helpdesk' and concat(e.given_name, e.family_name) = 'SharonWosbee')
go

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Employee groups:
select *
from employees e, `groups` g
go
select *
from employee_groups
go
INSERT INTO employee_groups(
     -- employee_group_id,
     employee_id,
     group_id
)
select e.employee_id,
       g.group_id
from employees e, `groups` g
where (g.group_name = 'Senior' and concat(e.given_name, e.family_name) = 'PhilipCarrington')
    or (g.group_name = 'Senior' and concat(e.given_name, e.family_name) = 'ChristopherKenbright')
    or (g.group_name = 'admin' and concat(e.given_name, e.family_name) = 'SharonWosbee')
go


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Folders:
INSERT INTO google_cloud_folders(
    -- google_cloud_folder_id,
    organisation_id,
    google_cloud_folder_parent_folder_id,
    google_cloud_folder_name,
    google_cloud_folder_short_description
)
select organisation_id,
       0,
       'Production',
       'All the Production projects go in here'
from organisations o 
union
select organisation_id,
       0,
       'Development',
       'All the Development projects go in here'
from organisations o 
union
select organisation_id,
       0,
       'Testing',
       'All the Testing projects go in here'
from organisations o 
go

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Projects:
INSERT INTO google_cloud_projects(
    -- google_cloud_project_id, 
    google_cloud_folder_id, 
    google_cloud_project_name, 
    google_cloud_project_id_actual, 
    google_cloud_project_number, 
    google_cloud_project_short_description
) 
select  gcf.google_cloud_folder_id,
       concat(o.organisation_identifier, '-', lower(gcf.google_cloud_folder_name)) as google_cloud_project_name,
       concat(o.organisation_identifier, '-', lower(gcf.google_cloud_folder_name)) as google_cloud_project_id_actual,
       12312412412 as google_cloud_project_number,
       concat('The ', gcf.google_cloud_folder_name, ' for ', o.organisation_name) as google_cloud_project_short_description
from google_cloud_folders gcf, organisations o
where gcf.google_cloud_folder_name = 'Production'
union
select  gcf.google_cloud_folder_id,
       concat(o.organisation_identifier, '-', lower(gcf.google_cloud_folder_name)) as google_cloud_project_name,
       concat(o.organisation_identifier, '-', lower(gcf.google_cloud_folder_name)) as google_cloud_project_id_actual,
       12312412410 as google_cloud_project_number,
       concat('The ', gcf.google_cloud_folder_name, ' for ', o.organisation_name) as google_cloud_project_short_description
from google_cloud_folders gcf, organisations o
where gcf.google_cloud_folder_name = 'Development'
union
select  gcf.google_cloud_folder_id,
       concat(o.organisation_identifier, '-', lower(gcf.google_cloud_folder_name)) as google_cloud_project_name,
       concat(o.organisation_identifier, '-', lower(gcf.google_cloud_folder_name)) as google_cloud_project_id_actual,
       12312412419 as google_cloud_project_number,
       concat('The ', gcf.google_cloud_folder_name, ' for ', o.organisation_name) as google_cloud_project_short_description
from google_cloud_folders gcf, organisations o
where gcf.google_cloud_folder_name = 'Testing'
go


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Organisation Department Team resources:
select *
from organisation_department_team_resources
go
select *
from google_cloud_resource_types gcrt, google_cloud_roles gcr, organisation_department_teams odt, google_cloud_projects gcp, google_cloud_locations gcl
go

INSERT INTO organisation_department_team_resources(
    -- organisation_department_team_resource_id, 
    google_cloud_resource_type_id, 
    google_cloud_role_id, 
    organisation_department_team_id,
    google_cloud_project_id,
    google_cloud_location_id
) 
select gcrt.google_cloud_resource_type_id,
       gcr.google_cloud_role_id,
       odt.organisation_department_team_id,
       gcp.google_cloud_project_id,
       gcl.google_cloud_location_id
from google_cloud_resource_types gcrt, google_cloud_roles gcr, organisation_department_teams odt, google_cloud_projects gcp, google_cloud_locations gcl
where (odt.organisation_department_team_id in (1,2,3,4) and gcr.google_cloud_role_id = 3 and gcl.google_cloud_location_name = 'EU')
go
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Job resources:
INSERT INTO job_resources(
    -- employee_job_resource_id, 
    google_cloud_resource_type_id, 
    google_cloud_role_id, 
    job_id,
    google_cloud_project_id,
    google_cloud_location_id
) 
select gcrt.google_cloud_resource_type_id,
       gcr.google_cloud_role_id,
       j.job_id,
       gcp.google_cloud_project_id,
       gcl.google_cloud_location_id
from google_cloud_resource_types gcrt, google_cloud_roles gcr, jobs j, google_cloud_projects gcp, google_cloud_locations gcl
where (j.job_id in (1,2,3,5,6,7,8) and gcr.google_cloud_role_id = 3 and gcp.google_cloud_project_name = 'csuk-production'  and gcl.google_cloud_location_name = 'EU')
go
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Group resources:
select *
from group_resources
go
select *
from google_cloud_resource_types gcrt, google_cloud_roles gcr, `groups` g, google_cloud_locations gcl,google_cloud_projects gcp
go
INSERT INTO group_resources(
--    employee_group_resource_id, 
    google_cloud_resource_type_id, 
    google_cloud_role_id, 
    group_id,
    google_cloud_project_id,
    google_cloud_location_id
) 
select gcrt.google_cloud_resource_type_id,
       gcr.google_cloud_role_id,
       g.group_id,
       gcp.google_cloud_project_id,
       gcl.google_cloud_location_id
from google_cloud_resource_types gcrt, google_cloud_roles gcr, `groups` g, google_cloud_projects gcp, google_cloud_locations gcl
where (g.group_name = 'Senior' and gcr.google_cloud_role_id = 3 and gcp.google_cloud_project_name = 'csuk-production'  and gcl.google_cloud_location_name = 'EU')
go

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Employee Resources:

INSERT INTO employee_resources(
    -- employee_resource_id, 
    google_cloud_resource_type_id, 
    google_cloud_role_id, 
    employee_id, 
    google_cloud_project_id, 
    google_cloud_location_id
) 
select gcrt.google_cloud_resource_type_id,
       gcr.google_cloud_role_id,
       e.employee_id,
       gcp.google_cloud_project_id,
       gcl.google_cloud_location_id
from google_cloud_resource_types gcrt, google_cloud_roles gcr, employees e, google_cloud_projects gcp, google_cloud_locations gcl
where (e.employee_id in (2, 1, 4)  and gcr.google_cloud_role_id = 3 and gcp.google_cloud_project_name = 'csuk-production' and gcl.google_cloud_location_name = 'EU')
go

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Service Account Resources:

INSERT INTO google_cloud_service_account_resources(
    -- service_account_resource_id, 
    google_cloud_resource_type_id, 
    google_cloud_role_id, 
    google_cloud_service_account_id, 
    google_cloud_project_id, 
    google_cloud_location_id
) 
select gcrt.google_cloud_resource_type_id,
       gcr.google_cloud_role_id,
       gcsa.google_cloud_service_account_id,
       gcp.google_cloud_project_id,
       gcl.google_cloud_location_id
from google_cloud_resource_types gcrt, google_cloud_roles gcr, google_cloud_service_accounts gcsa, google_cloud_projects gcp, google_cloud_locations gcl
where (
        gcsa.google_cloud_service_account_id in (1)  
            and gcr.google_cloud_role_id = 3 
            and gcp.google_cloud_project_name = 'csuk-production' 
            and gcl.google_cloud_location_name = 'EU'
      )
        

