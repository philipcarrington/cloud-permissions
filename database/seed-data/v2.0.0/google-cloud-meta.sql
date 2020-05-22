--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Google Cloud Regions:
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('asia-east1', '', 'a, b, c', 'Changhua County, Taiwan')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('asia-east2', '', 'a, b, c', 'Hong Kong')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('asia-northeast1', '', 'a, b, c', 'Tokyo, Japan')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('asia-northeast2', '', 'a, b, c', 'Osaka, Japan')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('asia-northeast3', '', 'a, b, c', 'Seoul, South Korea')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('asia-south1', '', 'a, b, c', 'Mumbai, India')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('asia-southeast1', '', 'a, b, c', 'Jurong West, Singapore')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('australia-southeast1', '', 'a, b, c', 'Sydney, Australia')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('europe-north1', '', 'a, b, c', 'Hamina, Finland')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('europe-west1', '', 'b, c, d', 'St. Ghislain, Belgium')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('europe-west2', '', 'a, b, c', 'London, England, UK')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('europe-west3', '', 'a, b, c', 'Frankfurt, Germany')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('europe-west4', '', 'a, b, c', 'Eemshaven, Netherlands')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('europe-west6', '', 'a, b, c', 'Zürich, Switzerland')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('northamerica-northeast1', '', 'a, b, c', 'Montréal, Québec, Canada')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('southamerica-east1', '', 'a, b, c', 'Osasco (São Paulo), Brazil')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('us-central1', '', 'a, b, c, f', 'Council Bluffs, Iowa, USA')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('us-east1', '', 'b, c, d', 'Moncks Corner, South Carolina, USA')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('us-east4', '', 'a, b, c', 'Ashburn, Northern Virginia, USA')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('us-west1', '', 'a, b, c', 'The Dalles, Oregon, USA')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('us-west2', '', 'a, b, c', 'Los Angeles, California, USA')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('us-west3', '', 'a, b, c', 'Salt Lake City, Utah, USA')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('us-west4', '', 'a, b, c', 'Las Vegas, Nevada, USA')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('EU', 'Data centers within member states of the European Union', '', '')
GO
INSERT INTO `permissions_meta`.`google_cloud_regions`(`google_cloud_region_name`, `google_cloud_region_short_description`, `google_cloud_region_zones`, `google_cloud_region_location`)
VALUES('USA', 'Data centers in the United States', '', '')
GO

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Google Cloud Locations:
INSERT INTO google_cloud_locations(
    -- google_cloud_location_id, 
    google_cloud_region_id, 
    google_cloud_location_name, 
    google_cloud_location_short_description
)
-- This will do for testing need a better solution:
select gcr.google_cloud_region_id,
       gcr.google_cloud_region_name,
       gcr.google_cloud_region_short_description
from google_cloud_regions gcr
go
select *
from google_cloud_locations
go


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Google Cloud Roles:

INSERT INTO google_cloud_roles(
    -- google_cloud_role_id, 
    google_cloud_role_title, 
    google_cloud_role_role, 
    google_cloud_role_short_description, 
    google_cloud_role_permissions, 
    google_cloud_role_lowest_resource
) 
VALUES
    ('Viewer', 'roles/viewer', '', 'Permissions for read-only actions that do not affect state, such as viewing (but not modifying) existing resources or data.', ''),    
    ('Editor', 'roles/editor', '', 'Permissions for read-only actions that do not affect state, such as viewing (but not modifying) existing resources or data.', ''),
    ('Owner', 'roles/owner', '', 'Permissions for read-only actions that do not affect state, such as viewing (but not modifying) existing resources or data.', '')
GO


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Google Cloud Resource Types:

INSERT INTO google_cloud_resource_types(
    -- google_cloud_resource_type_id,
   google_cloud_resource_type_service,  
    google_cloud_resource_type_name, 
    google_cloud_resource_type_short_description
) 
VALUES
    ('bigquery', 'dataset', 'GBQ lowest permissions')
GO
