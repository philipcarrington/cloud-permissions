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
    ('Senior', '', 'seni', ''),
    ('admin', '', 'admn', '')
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
-- Employee Jobs:

INSERT INTO employee_jobs(
    -- employee_job_id, 
    employee_id, 
    job_id
) 
select e.employee_id,
       j.job_id
from jobs j, employees e
where (j.job_id = 3 and e.employee_id = 1)
    or (j.job_id = 9 and e.employee_id = 2)
    or (j.job_id = 10 and e.employee_id = 3)
    or (j.job_id = 2 and e.employee_id = 4)
    or (j.job_id = 5 and e.employee_id = 5)
go

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Employee groups:


INSERT INTO employee_groups(
     -- employee_group_id,
     employee_id, 
     group_id
) 
select e.employee_id,
       g.group_id
from employees e, `groups` g
where (g.group_id = 7 and e.employee_id = 1)
    or (g.group_id = 7 and e.employee_id = 2)    
    or (g.group_id = 8 and e.employee_id = 3)
go  
  
  
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Organisation Department Team resources:

INSERT INTO organisation_department_team_resources(
    -- organisation_department_team_resource_id, 
    google_cloud_resource_type_id, 
    google_cloud_role_id, 
    organisation_department_team_id
) 
VALUES
    (0, 0, 0)
GO

select *
from google_cloud_resource_types gcrt, google_cloud_roles gcr, organisation_department_teams odt

