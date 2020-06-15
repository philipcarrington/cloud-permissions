DROP INDEX `uix_odd_c2` ON `departments`
GO
DROP INDEX `uix_ogced_c2c3c4` ON `employee_datasets`
GO
DROP INDEX `uix_odeg_c2c3` ON `employee_groups`
GO
DROP INDEX `uix_odejc2c3` ON `employee_jobs`
GO
DROP INDEX `uix_ogcegr_c2c3c4_2` ON `employee_resources`
GO
DROP INDEX `uix_ode_c2c3` ON `employees`
GO
DROP INDEX `uix_ogcgbd_c2c4` ON `google_bigquery_datasets`
GO
DROP INDEX `uix_ogcgbd_c2c4_1` ON `google_bigquery_datasets`
GO
DROP INDEX `uix_ogcgcp_c3` ON `google_cloud_projects`
GO
DROP INDEX `uix_gcmgcr_c2` ON `google_cloud_regions`
GO
DROP INDEX `uix_gcmrt_c2c3` ON `google_cloud_resource_types`
GO
DROP INDEX `uix_ogcsar_c2c3c4` ON `google_cloud_service_account_resources`
GO
DROP INDEX `uix_gcmgcsa_c2` ON `google_cloud_service_accounts`
GO
DROP INDEX `uix_ogcegd_c2c3c4` ON `group_datasets`
GO
DROP INDEX `uix_ogcegr_c2c3c4c5` ON `group_resources`
GO
DROP INDEX `uix_odg_c2` ON `groups`
GO
DROP INDEX `uix_ogcejd_c2c3c4_2` ON `job_datasets`
GO
DROP INDEX `uix_ogcegr_c2c3c4_1` ON `job_resources`
GO
DROP INDEX `uix_odj_c2` ON `jobs`
GO
DROP INDEX `uix_ogcodtd_c2c3c4` ON `organisation_department_team_datasets`
GO
DROP INDEX `uix_ododte_c2c3` ON `organisation_department_team_employees`
GO
DROP INDEX `uix_ogcodtgsa_c2c3` ON `organisation_department_team_google_service_accounts`
GO
DROP INDEX `uix_ogcodtr_c2c3c4` ON `organisation_department_team_resources`
GO
DROP INDEX `uix_ododt_c2c3c4` ON `organisation_department_teams`
GO
DROP INDEX `uix_odo_c2` ON `organisations`
GO
DROP INDEX `uix_odo_c4` ON `organisations`
GO
DROP INDEX `uix_ogcsad_c2c3c4` ON `service_account_datasets`
GO
DROP INDEX `uix_odt_c2` ON `teams`
GO
ALTER TABLE `employee_datasets`
	DROP FOREIGN KEY `REL_16`
GO
ALTER TABLE `employee_datasets`
	DROP FOREIGN KEY `REL_12`
GO
ALTER TABLE `employee_datasets`
	DROP FOREIGN KEY `REL_13`
GO
ALTER TABLE `employee_groups`
	DROP FOREIGN KEY `fk_ode_c1_to_odeg_c2`
GO
ALTER TABLE `employee_groups`
	DROP FOREIGN KEY `fk_odg_c1_to_odeg_c3`
GO
ALTER TABLE `employee_jobs`
	DROP FOREIGN KEY `fk_ode_c1_to_odej_c2`
GO
ALTER TABLE `employee_jobs`
	DROP FOREIGN KEY `fk_odj_c1_to_odej_c3`
GO
ALTER TABLE `employee_resources`
	DROP FOREIGN KEY `fk_gcmgcrt_c1_to_ogcer_c2`
GO
ALTER TABLE `employee_resources`
	DROP FOREIGN KEY `fk_gcmgcr_c1_to_ogcer_c3`
GO
ALTER TABLE `employee_resources`
	DROP FOREIGN KEY `fk_ode_c1_to_ogcer_c4`
GO
ALTER TABLE `employee_resources`
	DROP FOREIGN KEY `REL_30`
GO
ALTER TABLE `employee_resources`
	DROP FOREIGN KEY `REL_33`
GO
ALTER TABLE `google_bigquery_datasets`
	DROP FOREIGN KEY `fk_ogcgcp_c1_to_ogcgbd_c2`
GO
ALTER TABLE `google_bigquery_datasets`
	DROP FOREIGN KEY `fk_gcmgcl_c1_to_ogcgbd_c3`
GO
ALTER TABLE `google_cloud_folders`
	DROP FOREIGN KEY `fk_odo_c1_to_ogcgcf_c2`
GO
ALTER TABLE `google_cloud_locations`
	DROP FOREIGN KEY `fk_gcmgcr_c1_to_gcmgcl_c2`
GO
ALTER TABLE `google_cloud_projects`
	DROP FOREIGN KEY `fk_ogcgcf_c1_to_ogcgcp_c2`
GO
ALTER TABLE `google_cloud_service_account_resources`
	DROP FOREIGN KEY `REL_3`
GO
ALTER TABLE `google_cloud_service_account_resources`
	DROP FOREIGN KEY `REL_4`
GO
ALTER TABLE `google_cloud_service_account_resources`
	DROP FOREIGN KEY `fk_gcmgcsa_c1_to_ogcgcsar_c4`
GO
ALTER TABLE `google_cloud_service_account_resources`
	DROP FOREIGN KEY `REL_29`
GO
ALTER TABLE `google_cloud_service_account_resources`
	DROP FOREIGN KEY `REL_34`
GO
ALTER TABLE `group_datasets`
	DROP FOREIGN KEY `REL_18`
GO
ALTER TABLE `group_datasets`
	DROP FOREIGN KEY `REL_19`
GO
ALTER TABLE `group_datasets`
	DROP FOREIGN KEY `REL_14`
GO
ALTER TABLE `group_resources`
	DROP FOREIGN KEY `REL_21`
GO
ALTER TABLE `group_resources`
	DROP FOREIGN KEY `REL_22`
GO
ALTER TABLE `group_resources`
	DROP FOREIGN KEY `REL_20`
GO
ALTER TABLE `group_resources`
	DROP FOREIGN KEY `REL_27`
GO
ALTER TABLE `group_resources`
	DROP FOREIGN KEY `REL_31`
GO
ALTER TABLE `job_datasets`
	DROP FOREIGN KEY `REL_15`
GO
ALTER TABLE `job_datasets`
	DROP FOREIGN KEY `REL_17`
GO
ALTER TABLE `job_datasets`
	DROP FOREIGN KEY `REL_11`
GO
ALTER TABLE `job_resources`
	DROP FOREIGN KEY `REL_24`
GO
ALTER TABLE `job_resources`
	DROP FOREIGN KEY `REL_23`
GO
ALTER TABLE `job_resources`
	DROP FOREIGN KEY `REL_25`
GO
ALTER TABLE `job_resources`
	DROP FOREIGN KEY `REL_28`
GO
ALTER TABLE `job_resources`
	DROP FOREIGN KEY `REL_32`
GO
ALTER TABLE `organisation_department_team_datasets`
	DROP FOREIGN KEY `REL_5`
GO
ALTER TABLE `organisation_department_team_datasets`
	DROP FOREIGN KEY `REL_7`
GO
ALTER TABLE `organisation_department_team_datasets`
	DROP FOREIGN KEY `REL_6`
GO
ALTER TABLE `organisation_department_team_employees`
	DROP FOREIGN KEY `fk_ododt_c1_to_ododte_c2`
GO
ALTER TABLE `organisation_department_team_employees`
	DROP FOREIGN KEY `fk_ode_c1_to_ododte_c3`
GO
ALTER TABLE `organisation_department_team_google_service_accounts`
	DROP FOREIGN KEY `fk_ododt_c1_to_ogcodtgsa_c2`
GO
ALTER TABLE `organisation_department_team_google_service_accounts`
	DROP FOREIGN KEY `fk_gcmgcsa_c1_to_ogcodtgsa_c3`
GO
ALTER TABLE `organisation_department_team_resources`
	DROP FOREIGN KEY `REL_1`
GO
ALTER TABLE `organisation_department_team_resources`
	DROP FOREIGN KEY `REL_2`
GO
ALTER TABLE `organisation_department_team_resources`
	DROP FOREIGN KEY `fk_ododt_c1_to_ogcodtr_c4`
GO
ALTER TABLE `organisation_department_team_resources`
	DROP FOREIGN KEY `REL_26`
GO
ALTER TABLE `organisation_department_team_resources`
	DROP FOREIGN KEY `REL_35`
GO
ALTER TABLE `organisation_department_teams`
	DROP FOREIGN KEY `fk_odo_c1_to_ododt_c2`
GO
ALTER TABLE `organisation_department_teams`
	DROP FOREIGN KEY `fk_odd_c1_to_ododt_c3`
GO
ALTER TABLE `organisation_department_teams`
	DROP FOREIGN KEY `fk_odt_c1_to_ododt_c3`
GO
ALTER TABLE `service_account_datasets`
	DROP FOREIGN KEY `REL_8`
GO
ALTER TABLE `service_account_datasets`
	DROP FOREIGN KEY `REL_10`
GO
ALTER TABLE `service_account_datasets`
	DROP FOREIGN KEY `REL_9`
GO
ALTER TABLE `google_cloud_locations`
	DROP INDEX `uix_gcmgcl_c3`
GO
ALTER TABLE `google_cloud_roles`
	DROP INDEX `uix_gcmgcr_c2`
GO
DROP TABLE IF EXISTS `departments`
GO
DROP TABLE IF EXISTS `employee_datasets`
GO
DROP TABLE IF EXISTS `employee_groups`
GO
DROP TABLE IF EXISTS `employee_jobs`
GO
DROP TABLE IF EXISTS `employee_resources`
GO
DROP TABLE IF EXISTS `employees`
GO
DROP TABLE IF EXISTS `google_bigquery_datasets`
GO
DROP TABLE IF EXISTS `google_bigquery_datasets`
GO
DROP TABLE IF EXISTS `google_cloud_folders`
GO
DROP TABLE IF EXISTS `google_cloud_locations`
GO
DROP TABLE IF EXISTS `google_cloud_projects`
GO
DROP TABLE IF EXISTS `google_cloud_regions`
GO
DROP TABLE IF EXISTS `google_cloud_resource_types`
GO
DROP TABLE IF EXISTS `google_cloud_roles`
GO
DROP TABLE IF EXISTS `google_cloud_service_account_resources`
GO
DROP TABLE IF EXISTS `google_cloud_service_accounts`
GO
DROP TABLE IF EXISTS `group_datasets`
GO
DROP TABLE IF EXISTS `group_resources`
GO
DROP TABLE IF EXISTS `groups`
GO
DROP TABLE IF EXISTS `job_datasets`
GO
DROP TABLE IF EXISTS `job_resources`
GO
DROP TABLE IF EXISTS `jobs`
GO
DROP TABLE IF EXISTS `organisation_department_team_datasets`
GO
DROP TABLE IF EXISTS `organisation_department_team_employees`
GO
DROP TABLE IF EXISTS `organisation_department_team_google_service_accounts`
GO
DROP TABLE IF EXISTS `organisation_department_team_resources`
GO
DROP TABLE IF EXISTS `organisation_department_teams`
GO
DROP TABLE IF EXISTS `organisations`
GO
DROP TABLE IF EXISTS `service_account_datasets`
GO
DROP TABLE IF EXISTS `teams`
GO
CREATE TABLE `departments`  (
	`department_id`        	int AUTO_INCREMENT NOT NULL,
	`department_name`      	varchar(255) NOT NULL,
	`department_short_desc`	varchar(500) NULL,
	PRIMARY KEY(`department_id`)
)
GO
CREATE TABLE `employee_datasets`  (
	`employee_dataset_id`       	int AUTO_INCREMENT NOT NULL,
	`employee_id`               	int NOT NULL,
	`google_cloud_role_id`      	int NOT NULL,
	`google_bigquery_dataset_id`	int NOT NULL,
	PRIMARY KEY(`employee_dataset_id`)
)
GO
CREATE TABLE `employee_groups`  (
	`employee_group_id`	int AUTO_INCREMENT NOT NULL,
	`employee_id`      	int NOT NULL,
	`group_id`         	int NOT NULL,
	PRIMARY KEY(`employee_group_id`)
)
GO
CREATE TABLE `employee_jobs`  (
	`employee_job_id`	int AUTO_INCREMENT NOT NULL,
	`employee_id`    	int NOT NULL,
	`job_id`         	int NOT NULL,
	PRIMARY KEY(`employee_job_id`)
)
GO
CREATE TABLE `employee_resources`  (
	`employee_resource_id`         	int AUTO_INCREMENT NOT NULL,
	`google_cloud_resource_type_id`	int NOT NULL,
	`google_cloud_role_id`         	int NOT NULL,
	`employee_id`                  	int NOT NULL,
	`google_cloud_project_id`      	int NOT NULL,
	`google_cloud_location_id`     	int NOT NULL,
	PRIMARY KEY(`employee_resource_id`)
)
GO
CREATE TABLE `employees`  (
	`employee_id`	int AUTO_INCREMENT NOT NULL,
	`given_name` 	varchar(200) NOT NULL,
	`family_name`	varchar(200) NOT NULL,
	PRIMARY KEY(`employee_id`)
)
GO
CREATE TABLE `google_bigquery_datasets`  (
	`google_bigquery_dataset_id`                          	int AUTO_INCREMENT NOT NULL,
	`google_cloud_project_id`                             	int NOT NULL,
	`google_cloud_location_id`                            	int NOT NULL,
	`google_bigquery_dataset_name`                        	varchar(255) NOT NULL,
	`google_bigquery_dataset_short_description`           	varchar(500) NULL,
	`google_bigquery_dataset_default_table_expiration`    	smallint NOT NULL DEFAULT '0',
	`google_bigquery_dataset_default_partition_expiration`	smallint NOT NULL DEFAULT '0',
	PRIMARY KEY(`google_bigquery_dataset_id`)
)
GO
CREATE TABLE `google_bigquery_datasets`  (
	`google_bigquery_dataset_id`                          	int NOT NULL,
	`google_cloud_project_id`                             	int NOT NULL,
	`google_cloud_location_id`                            	int NOT NULL,
	`google_bigquery_dataset_name`                        	varchar(255) NOT NULL,
	`google_bigquery_dataset_short_description`           	varchar(500) NULL,
	`google_bigquery_dataset_default_table_expiration`    	smallint NOT NULL DEFAULT '0',
	`google_bigquery_dataset_default_partition_expiration`	smallint NOT NULL DEFAULT '0',
	`google_bigquery_dataset_history_action`              	smallint NOT NULL,
	`google_bigquery_dataset_history_datetime`            	datetime NOT NULL,
	`google_bigquery_dataset_history_user`                	varchar(100) NOT NULL,
	PRIMARY KEY(`google_bigquery_dataset_id`)
)
GO
CREATE TABLE `google_cloud_folders`  (
	`google_cloud_folder_id`               	int AUTO_INCREMENT NOT NULL,
	`organisation_id`                      	int NOT NULL,
	`google_cloud_folder_parent_folder_id` 	int NOT NULL DEFAULT '0',
	`google_cloud_folder_name`             	varchar(255) NOT NULL,
	`google_cloud_folder_short_description`	varchar(500) NULL,
	PRIMARY KEY(`google_cloud_folder_id`)
)
GO
CREATE TABLE `google_cloud_locations`  (
	`google_cloud_location_id`               	int AUTO_INCREMENT NOT NULL,
	`google_cloud_region_id`                 	int NOT NULL,
	`google_cloud_location_name`             	varchar(255) NOT NULL,
	`google_cloud_location_short_description`	varchar(500) NULL,
	PRIMARY KEY(`google_cloud_location_id`)
)
GO
CREATE TABLE `google_cloud_projects`  (
	`google_cloud_project_id`               	int AUTO_INCREMENT NOT NULL,
	`google_cloud_folder_id`                	int ZEROFILL NOT NULL,
	`google_cloud_project_name`             	varchar(255) NOT NULL,
	`google_cloud_project_id_actual`        	varchar(25) NULL,
	`google_cloud_project_number`           	varchar(25) NULL,
	`google_cloud_project_short_description`	varchar(500) NULL,
	PRIMARY KEY(`google_cloud_project_id`)
)
GO
CREATE TABLE `google_cloud_regions`  (
	`google_cloud_region_id`               	int AUTO_INCREMENT NOT NULL,
	`google_cloud_region_name`             	varchar(255) NOT NULL,
	`google_cloud_region_zones`            	varchar(100) NULL,
	`google_cloud_region_location`         	varchar(100) NULL,
	`google_cloud_region_short_description`	varchar(500) NULL,
	PRIMARY KEY(`google_cloud_region_id`)
)
GO
CREATE TABLE `google_cloud_resource_types`  (
	`google_cloud_resource_type_id`               	int AUTO_INCREMENT NOT NULL,
	`google_cloud_resource_type_service`          	varchar(255) NOT NULL,
	`google_cloud_resource_type_name`             	varchar(255) NOT NULL,
	`google_cloud_resource_type_short_description`	varchar(500) NULL,
	PRIMARY KEY(`google_cloud_resource_type_id`)
)
GO
CREATE TABLE `google_cloud_roles`  (
	`google_cloud_role_id`               	int AUTO_INCREMENT NOT NULL,
	`google_cloud_role_title`            	varchar(255) NOT NULL,
	`google_cloud_role_role`             	varchar(255) NOT NULL,
	`google_cloud_role_short_description`	varchar(500) NULL,
	`google_cloud_role_permissions`      	varchar(500) NULL,
	`google_cloud_role_lowest_resource`  	varchar(255) NULL,
	PRIMARY KEY(`google_cloud_role_id`)
)
GO
CREATE TABLE `google_cloud_service_account_resources`  (
	`service_account_resource_id`    	int AUTO_INCREMENT NOT NULL,
	`google_cloud_resource_type_id`  	int NOT NULL,
	`google_cloud_role_id`           	int NOT NULL,
	`google_cloud_service_account_id`	int NOT NULL,
	`google_cloud_project_id`        	int NOT NULL,
	`google_cloud_location_id`       	int NOT NULL,
	PRIMARY KEY(`service_account_resource_id`)
)
GO
CREATE TABLE `google_cloud_service_accounts`  (
	`google_cloud_service_account_id`         	int AUTO_INCREMENT NOT NULL,
	`google_cloud_service_account_email`      	varchar(255) NOT NULL,
	`google_cloud_service_account_name`       	varchar(255) NULL,
	`google_cloud_service_account_status`     	smallint NOT NULL DEFAULT '1',
	`google_cloud_service_account_description`	varchar(500) NULL,
	PRIMARY KEY(`google_cloud_service_account_id`)
)
GO
CREATE TABLE `group_datasets`  (
	`group_dataset_id`          	int AUTO_INCREMENT NOT NULL,
	`group_id`                  	int NOT NULL,
	`google_cloud_role_id`      	int NOT NULL,
	`google_bigquery_dataset_id`	int NOT NULL,
	PRIMARY KEY(`group_dataset_id`)
)
GO
CREATE TABLE `group_resources`  (
	`group_resource_id`            	int AUTO_INCREMENT NOT NULL,
	`google_cloud_resource_type_id`	int NOT NULL,
	`google_cloud_role_id`         	int NOT NULL,
	`group_id`                     	int NOT NULL,
	`google_cloud_project_id`      	int NOT NULL,
	`google_cloud_location_id`     	int NOT NULL,
	PRIMARY KEY(`group_resource_id`)
)
GO
CREATE TABLE `groups`  (
	`group_id`               	int AUTO_INCREMENT NOT NULL,
	`group_name`             	varchar(255) NOT NULL,
	`group_short_description`	varchar(500) NULL,
	`group_prefix`           	varchar(25) NULL,
	`group_suffix`           	varchar(25) NULL,
	PRIMARY KEY(`group_id`)
)
GO
CREATE TABLE `job_datasets`  (
	`job_dataset_id`            	int AUTO_INCREMENT NOT NULL,
	`job_id`                    	int NOT NULL,
	`google_cloud_role_id`      	int NOT NULL,
	`google_bigquery_dataset_id`	int NOT NULL,
	PRIMARY KEY(`job_dataset_id`)
)
GO
CREATE TABLE `job_resources`  (
	`job_resource_id`              	int AUTO_INCREMENT NOT NULL,
	`google_cloud_resource_type_id`	int NOT NULL,
	`google_cloud_role_id`         	int NOT NULL,
	`job_id`                       	int NOT NULL,
	`google_cloud_project_id`      	int NOT NULL,
	`google_cloud_location_id`     	int NOT NULL,
	PRIMARY KEY(`job_resource_id`)
)
GO
CREATE TABLE `jobs`  (
	`job_id`               	int AUTO_INCREMENT NOT NULL,
	`job_name`             	varchar(255) NOT NULL,
	`job_short_description`	varchar(500) NULL,
	PRIMARY KEY(`job_id`)
)
GO
CREATE TABLE `organisation_department_team_datasets`  (
	`organisation_department_team_dataset_id`	int AUTO_INCREMENT NOT NULL,
	`organisation_department_team_id`        	int NOT NULL,
	`google_cloud_role_id`                   	int NOT NULL,
	`google_bigquery_dataset_id`             	int NOT NULL,
	PRIMARY KEY(`organisation_department_team_dataset_id`)
)
GO
CREATE TABLE `organisation_department_team_employees`  (
	`organisation_department_team_employee_id`	int AUTO_INCREMENT NOT NULL,
	`organisation_department_team_id`         	int NOT NULL,
	`employee_id`                             	int NOT NULL,
	PRIMARY KEY(`organisation_department_team_employee_id`)
)
GO
CREATE TABLE `organisation_department_team_google_service_accounts`  (
	`organisation_department_team_google_service_account_id`	int AUTO_INCREMENT NOT NULL,
	`organisation_department_team_id`                       	int NOT NULL,
	`google_cloud_service_account_id`                       	int NOT NULL,
	PRIMARY KEY(`organisation_department_team_google_service_account_id`)
)
GO
CREATE TABLE `organisation_department_team_resources`  (
	`organisation_department_team_resource_id`	int AUTO_INCREMENT NOT NULL,
	`google_cloud_resource_type_id`           	int NOT NULL,
	`google_cloud_role_id`                    	int NOT NULL,
	`organisation_department_team_id`         	int NOT NULL,
	`google_cloud_project_id`                 	int NOT NULL,
	`google_cloud_location_id`                	int NOT NULL,
	PRIMARY KEY(`organisation_department_team_resource_id`)
)
GO
CREATE TABLE `organisation_department_teams`  (
	`organisation_department_team_id`               	int AUTO_INCREMENT NOT NULL,
	`organisation_id`                               	int NOT NULL,
	`department_id`                                 	int NOT NULL,
	`team_id`                                       	int NOT NULL,
	`organisation_department_team_short_description`	varchar(500) NULL,
	PRIMARY KEY(`organisation_department_team_id`)
)
GO
CREATE TABLE `organisations`  (
	`organisation_id`               	int AUTO_INCREMENT NOT NULL,
	`organisation_name`             	varchar(255) NOT NULL,
	`organisation_short_description`	varchar(500) NULL,
	`organisation_identifier`       	varchar(25) NOT NULL,
	`organisation_email_domain`     	varchar(255) NOT NULL,
	PRIMARY KEY(`organisation_id`)
)
GO
CREATE TABLE `service_account_datasets`  (
	`service_account_dataset_id`     	int AUTO_INCREMENT NOT NULL,
	`google_cloud_service_account_id`	int NOT NULL,
	`google_cloud_role_id`           	int NOT NULL,
	`google_bigquery_dataset_id`     	int NOT NULL,
	PRIMARY KEY(`service_account_dataset_id`)
)
GO
CREATE TABLE `teams`  (
	`team_id`               	int AUTO_INCREMENT NOT NULL,
	`team_name`             	varchar(255) NOT NULL,
	`team_short_description`	varchar(500) NULL,
	PRIMARY KEY(`team_id`)
)
GO
ALTER TABLE `google_cloud_locations`
	ADD CONSTRAINT `uix_gcmgcl_c3`
	UNIQUE (`google_cloud_location_name`)
GO
ALTER TABLE `google_cloud_roles`
	ADD CONSTRAINT `uix_gcmgcr_c2`
	UNIQUE (`google_cloud_role_title`)
GO
ALTER TABLE `employee_datasets`
	ADD CONSTRAINT `REL_16`
	FOREIGN KEY(`employee_id`)
	REFERENCES `employees`(`employee_id`)
GO
ALTER TABLE `employee_datasets`
	ADD CONSTRAINT `REL_12`
	FOREIGN KEY(`google_cloud_role_id`)
	REFERENCES `google_cloud_roles`(`google_cloud_role_id`)
GO
ALTER TABLE `employee_datasets`
	ADD CONSTRAINT `REL_13`
	FOREIGN KEY(`google_bigquery_dataset_id`)
	REFERENCES `google_bigquery_datasets`(`google_bigquery_dataset_id`)
GO
ALTER TABLE `employee_groups`
	ADD CONSTRAINT `fk_ode_c1_to_odeg_c2`
	FOREIGN KEY(`employee_id`)
	REFERENCES `employees`(`employee_id`)
GO
ALTER TABLE `employee_groups`
	ADD CONSTRAINT `fk_odg_c1_to_odeg_c3`
	FOREIGN KEY(`group_id`)
	REFERENCES `groups`(`group_id`)
GO
ALTER TABLE `employee_jobs`
	ADD CONSTRAINT `fk_ode_c1_to_odej_c2`
	FOREIGN KEY(`employee_id`)
	REFERENCES `employees`(`employee_id`)
GO
ALTER TABLE `employee_jobs`
	ADD CONSTRAINT `fk_odj_c1_to_odej_c3`
	FOREIGN KEY(`job_id`)
	REFERENCES `jobs`(`job_id`)
GO
ALTER TABLE `employee_resources`
	ADD CONSTRAINT `fk_gcmgcrt_c1_to_ogcer_c2`
	FOREIGN KEY(`google_cloud_resource_type_id`)
	REFERENCES `google_cloud_resource_types`(`google_cloud_resource_type_id`)
GO
ALTER TABLE `employee_resources`
	ADD CONSTRAINT `fk_gcmgcr_c1_to_ogcer_c3`
	FOREIGN KEY(`google_cloud_role_id`)
	REFERENCES `google_cloud_roles`(`google_cloud_role_id`)
GO
ALTER TABLE `employee_resources`
	ADD CONSTRAINT `fk_ode_c1_to_ogcer_c4`
	FOREIGN KEY(`employee_id`)
	REFERENCES `employees`(`employee_id`)
GO
ALTER TABLE `employee_resources`
	ADD CONSTRAINT `REL_30`
	FOREIGN KEY(`google_cloud_project_id`)
	REFERENCES `google_cloud_projects`(`google_cloud_project_id`)
GO
ALTER TABLE `employee_resources`
	ADD CONSTRAINT `REL_33`
	FOREIGN KEY(`google_cloud_location_id`)
	REFERENCES `google_cloud_locations`(`google_cloud_location_id`)
GO
ALTER TABLE `google_bigquery_datasets`
	ADD CONSTRAINT `fk_ogcgcp_c1_to_ogcgbd_c2`
	FOREIGN KEY(`google_cloud_project_id`)
	REFERENCES `google_cloud_projects`(`google_cloud_project_id`)
GO
ALTER TABLE `google_bigquery_datasets`
	ADD CONSTRAINT `fk_gcmgcl_c1_to_ogcgbd_c3`
	FOREIGN KEY(`google_cloud_location_id`)
	REFERENCES `google_cloud_locations`(`google_cloud_location_id`)
GO
ALTER TABLE `google_cloud_folders`
	ADD CONSTRAINT `fk_odo_c1_to_ogcgcf_c2`
	FOREIGN KEY(`organisation_id`)
	REFERENCES `organisations`(`organisation_id`)
GO
ALTER TABLE `google_cloud_locations`
	ADD CONSTRAINT `fk_gcmgcr_c1_to_gcmgcl_c2`
	FOREIGN KEY(`google_cloud_region_id`)
	REFERENCES `google_cloud_regions`(`google_cloud_region_id`)
GO
ALTER TABLE `google_cloud_projects`
	ADD CONSTRAINT `fk_ogcgcf_c1_to_ogcgcp_c2`
	FOREIGN KEY(`google_cloud_folder_id`)
	REFERENCES `google_cloud_folders`(`google_cloud_folder_id`)
GO
ALTER TABLE `google_cloud_service_account_resources`
	ADD CONSTRAINT `REL_3`
	FOREIGN KEY(`google_cloud_resource_type_id`)
	REFERENCES `google_cloud_resource_types`(`google_cloud_resource_type_id`)
GO
ALTER TABLE `google_cloud_service_account_resources`
	ADD CONSTRAINT `REL_4`
	FOREIGN KEY(`google_cloud_role_id`)
	REFERENCES `google_cloud_roles`(`google_cloud_role_id`)
GO
ALTER TABLE `google_cloud_service_account_resources`
	ADD CONSTRAINT `fk_gcmgcsa_c1_to_ogcgcsar_c4`
	FOREIGN KEY(`google_cloud_service_account_id`)
	REFERENCES `google_cloud_service_accounts`(`google_cloud_service_account_id`)
GO
ALTER TABLE `google_cloud_service_account_resources`
	ADD CONSTRAINT `REL_29`
	FOREIGN KEY(`google_cloud_project_id`)
	REFERENCES `google_cloud_projects`(`google_cloud_project_id`)
GO
ALTER TABLE `google_cloud_service_account_resources`
	ADD CONSTRAINT `REL_34`
	FOREIGN KEY(`google_cloud_location_id`)
	REFERENCES `google_cloud_locations`(`google_cloud_location_id`)
GO
ALTER TABLE `group_datasets`
	ADD CONSTRAINT `REL_18`
	FOREIGN KEY(`group_id`)
	REFERENCES `groups`(`group_id`)
GO
ALTER TABLE `group_datasets`
	ADD CONSTRAINT `REL_19`
	FOREIGN KEY(`google_cloud_role_id`)
	REFERENCES `google_cloud_roles`(`google_cloud_role_id`)
GO
ALTER TABLE `group_datasets`
	ADD CONSTRAINT `REL_14`
	FOREIGN KEY(`google_bigquery_dataset_id`)
	REFERENCES `google_bigquery_datasets`(`google_bigquery_dataset_id`)
GO
ALTER TABLE `group_resources`
	ADD CONSTRAINT `REL_21`
	FOREIGN KEY(`google_cloud_resource_type_id`)
	REFERENCES `google_cloud_resource_types`(`google_cloud_resource_type_id`)
GO
ALTER TABLE `group_resources`
	ADD CONSTRAINT `REL_22`
	FOREIGN KEY(`google_cloud_role_id`)
	REFERENCES `google_cloud_roles`(`google_cloud_role_id`)
GO
ALTER TABLE `group_resources`
	ADD CONSTRAINT `REL_20`
	FOREIGN KEY(`group_id`)
	REFERENCES `groups`(`group_id`)
GO
ALTER TABLE `group_resources`
	ADD CONSTRAINT `REL_27`
	FOREIGN KEY(`google_cloud_project_id`)
	REFERENCES `google_cloud_projects`(`google_cloud_project_id`)
GO
ALTER TABLE `group_resources`
	ADD CONSTRAINT `REL_31`
	FOREIGN KEY(`google_cloud_location_id`)
	REFERENCES `google_cloud_locations`(`google_cloud_location_id`)
GO
ALTER TABLE `job_datasets`
	ADD CONSTRAINT `REL_15`
	FOREIGN KEY(`job_id`)
	REFERENCES `jobs`(`job_id`)
GO
ALTER TABLE `job_datasets`
	ADD CONSTRAINT `REL_17`
	FOREIGN KEY(`google_cloud_role_id`)
	REFERENCES `google_cloud_roles`(`google_cloud_role_id`)
GO
ALTER TABLE `job_datasets`
	ADD CONSTRAINT `REL_11`
	FOREIGN KEY(`google_bigquery_dataset_id`)
	REFERENCES `google_bigquery_datasets`(`google_bigquery_dataset_id`)
GO
ALTER TABLE `job_resources`
	ADD CONSTRAINT `REL_24`
	FOREIGN KEY(`google_cloud_resource_type_id`)
	REFERENCES `google_cloud_resource_types`(`google_cloud_resource_type_id`)
GO
ALTER TABLE `job_resources`
	ADD CONSTRAINT `REL_23`
	FOREIGN KEY(`google_cloud_role_id`)
	REFERENCES `google_cloud_roles`(`google_cloud_role_id`)
GO
ALTER TABLE `job_resources`
	ADD CONSTRAINT `REL_25`
	FOREIGN KEY(`job_id`)
	REFERENCES `jobs`(`job_id`)
GO
ALTER TABLE `job_resources`
	ADD CONSTRAINT `REL_28`
	FOREIGN KEY(`google_cloud_project_id`)
	REFERENCES `google_cloud_projects`(`google_cloud_project_id`)
GO
ALTER TABLE `job_resources`
	ADD CONSTRAINT `REL_32`
	FOREIGN KEY(`google_cloud_location_id`)
	REFERENCES `google_cloud_locations`(`google_cloud_location_id`)
GO
ALTER TABLE `organisation_department_team_datasets`
	ADD CONSTRAINT `REL_5`
	FOREIGN KEY(`organisation_department_team_id`)
	REFERENCES `organisation_department_teams`(`organisation_department_team_id`)
GO
ALTER TABLE `organisation_department_team_datasets`
	ADD CONSTRAINT `REL_7`
	FOREIGN KEY(`google_cloud_role_id`)
	REFERENCES `google_cloud_roles`(`google_cloud_role_id`)
GO
ALTER TABLE `organisation_department_team_datasets`
	ADD CONSTRAINT `REL_6`
	FOREIGN KEY(`google_bigquery_dataset_id`)
	REFERENCES `google_bigquery_datasets`(`google_bigquery_dataset_id`)
GO
ALTER TABLE `organisation_department_team_employees`
	ADD CONSTRAINT `fk_ododt_c1_to_ododte_c2`
	FOREIGN KEY(`organisation_department_team_id`)
	REFERENCES `organisation_department_teams`(`organisation_department_team_id`)
GO
ALTER TABLE `organisation_department_team_employees`
	ADD CONSTRAINT `fk_ode_c1_to_ododte_c3`
	FOREIGN KEY(`employee_id`)
	REFERENCES `employees`(`employee_id`)
GO
ALTER TABLE `organisation_department_team_google_service_accounts`
	ADD CONSTRAINT `fk_ododt_c1_to_ogcodtgsa_c2`
	FOREIGN KEY(`organisation_department_team_id`)
	REFERENCES `organisation_department_teams`(`organisation_department_team_id`)
GO
ALTER TABLE `organisation_department_team_google_service_accounts`
	ADD CONSTRAINT `fk_gcmgcsa_c1_to_ogcodtgsa_c3`
	FOREIGN KEY(`google_cloud_service_account_id`)
	REFERENCES `google_cloud_service_accounts`(`google_cloud_service_account_id`)
GO
ALTER TABLE `organisation_department_team_resources`
	ADD CONSTRAINT `REL_1`
	FOREIGN KEY(`google_cloud_resource_type_id`)
	REFERENCES `google_cloud_resource_types`(`google_cloud_resource_type_id`)
GO
ALTER TABLE `organisation_department_team_resources`
	ADD CONSTRAINT `REL_2`
	FOREIGN KEY(`google_cloud_role_id`)
	REFERENCES `google_cloud_roles`(`google_cloud_role_id`)
GO
ALTER TABLE `organisation_department_team_resources`
	ADD CONSTRAINT `fk_ododt_c1_to_ogcodtr_c4`
	FOREIGN KEY(`organisation_department_team_id`)
	REFERENCES `organisation_department_teams`(`organisation_department_team_id`)
GO
ALTER TABLE `organisation_department_team_resources`
	ADD CONSTRAINT `REL_26`
	FOREIGN KEY(`google_cloud_project_id`)
	REFERENCES `google_cloud_projects`(`google_cloud_project_id`)
GO
ALTER TABLE `organisation_department_team_resources`
	ADD CONSTRAINT `REL_35`
	FOREIGN KEY(`google_cloud_location_id`)
	REFERENCES `google_cloud_locations`(`google_cloud_location_id`)
GO
ALTER TABLE `organisation_department_teams`
	ADD CONSTRAINT `fk_odo_c1_to_ododt_c2`
	FOREIGN KEY(`organisation_id`)
	REFERENCES `organisations`(`organisation_id`)
	ON DELETE NO ACTION
GO
ALTER TABLE `organisation_department_teams`
	ADD CONSTRAINT `fk_odd_c1_to_ododt_c3`
	FOREIGN KEY(`department_id`)
	REFERENCES `departments`(`department_id`)
GO
ALTER TABLE `organisation_department_teams`
	ADD CONSTRAINT `fk_odt_c1_to_ododt_c3`
	FOREIGN KEY(`team_id`)
	REFERENCES `teams`(`team_id`)
GO
ALTER TABLE `service_account_datasets`
	ADD CONSTRAINT `REL_8`
	FOREIGN KEY(`google_cloud_service_account_id`)
	REFERENCES `google_cloud_service_accounts`(`google_cloud_service_account_id`)
GO
ALTER TABLE `service_account_datasets`
	ADD CONSTRAINT `REL_10`
	FOREIGN KEY(`google_cloud_role_id`)
	REFERENCES `google_cloud_roles`(`google_cloud_role_id`)
GO
ALTER TABLE `service_account_datasets`
	ADD CONSTRAINT `REL_9`
	FOREIGN KEY(`google_bigquery_dataset_id`)
	REFERENCES `google_bigquery_datasets`(`google_bigquery_dataset_id`)
GO
CREATE UNIQUE INDEX `uix_odd_c2`
	ON `departments`(`department_name`)
GO
CREATE UNIQUE INDEX `uix_ogced_c2c3c4`
	ON `employee_datasets`(`employee_id`, `google_cloud_role_id`, `google_bigquery_dataset_id`)
GO
CREATE UNIQUE INDEX `uix_odeg_c2c3`
	ON `employee_groups`(`employee_id`, `group_id`)
GO
CREATE UNIQUE INDEX `uix_odejc2c3`
	ON `employee_jobs`(`employee_id`, `job_id`)
GO
CREATE UNIQUE INDEX `uix_ogcegr_c2c3c4_2`
	ON `employee_resources`(`google_cloud_resource_type_id`, `google_cloud_role_id`, `employee_id`, `google_cloud_project_id`, `google_cloud_location_id`)
GO
CREATE UNIQUE INDEX `uix_ode_c2c3`
	ON `employees`(`given_name`, `family_name`)
GO
CREATE UNIQUE INDEX `uix_ogcgbd_c2c4`
	ON `google_bigquery_datasets`(`google_cloud_project_id`, `google_bigquery_dataset_name`)
GO
CREATE UNIQUE INDEX `uix_ogcgbd_c2c4_1`
	ON `google_bigquery_datasets`(`google_cloud_project_id`, `google_bigquery_dataset_name`)
GO
CREATE UNIQUE INDEX `uix_ogcgcp_c3`
	ON `google_cloud_projects`(`google_cloud_project_name`)
GO
CREATE UNIQUE INDEX `uix_gcmgcr_c2`
	ON `google_cloud_regions`(`google_cloud_region_name`)
GO
CREATE UNIQUE INDEX `uix_gcmrt_c2c3`
	ON `google_cloud_resource_types`(`google_cloud_resource_type_service`, `google_cloud_resource_type_name`)
GO
CREATE UNIQUE INDEX `uix_ogcsar_c2c3c4`
	ON `google_cloud_service_account_resources`(`google_cloud_resource_type_id`, `google_cloud_role_id`, `google_cloud_service_account_id`, `google_cloud_project_id`, `google_cloud_location_id` DESC)
GO
CREATE UNIQUE INDEX `uix_gcmgcsa_c2`
	ON `google_cloud_service_accounts`(`google_cloud_service_account_email`)
GO
CREATE UNIQUE INDEX `uix_ogcegd_c2c3c4`
	ON `group_datasets`(`group_id`, `google_cloud_role_id`, `google_bigquery_dataset_id`)
GO
CREATE UNIQUE INDEX `uix_ogcegr_c2c3c4c5`
	ON `group_resources`(`google_cloud_resource_type_id`, `google_cloud_role_id`, `group_id`, `google_cloud_project_id`, `google_cloud_location_id`)
GO
CREATE UNIQUE INDEX `uix_odg_c2`
	ON `groups`(`group_name`)
GO
CREATE UNIQUE INDEX `uix_ogcejd_c2c3c4_2`
	ON `job_datasets`(`job_id`, `google_cloud_role_id`, `google_bigquery_dataset_id`)
GO
CREATE UNIQUE INDEX `uix_ogcegr_c2c3c4_1`
	ON `job_resources`(`google_cloud_resource_type_id`, `google_cloud_role_id`, `job_id`, `google_cloud_project_id`, `google_cloud_location_id`)
GO
CREATE UNIQUE INDEX `uix_odj_c2`
	ON `jobs`(`job_name`)
GO
CREATE UNIQUE INDEX `uix_ogcodtd_c2c3c4`
	ON `organisation_department_team_datasets`(`organisation_department_team_id`, `google_cloud_role_id`, `google_bigquery_dataset_id`)
GO
CREATE UNIQUE INDEX `uix_ododte_c2c3`
	ON `organisation_department_team_employees`(`organisation_department_team_id`, `employee_id`)
GO
CREATE UNIQUE INDEX `uix_ogcodtgsa_c2c3`
	ON `organisation_department_team_google_service_accounts`(`organisation_department_team_id`, `google_cloud_service_account_id`)
GO
CREATE UNIQUE INDEX `uix_ogcodtr_c2c3c4`
	ON `organisation_department_team_resources`(`google_cloud_resource_type_id`, `google_cloud_role_id`, `organisation_department_team_id`, `google_cloud_project_id`, `google_cloud_location_id`)
GO
CREATE UNIQUE INDEX `uix_ododt_c2c3c4`
	ON `organisation_department_teams`(`organisation_id`, `department_id`, `team_id`)
GO
CREATE UNIQUE INDEX `uix_odo_c2`
	ON `organisations`(`organisation_name`)
GO
CREATE UNIQUE INDEX `uix_odo_c4`
	ON `organisations`(`organisation_identifier`)
GO
CREATE UNIQUE INDEX `uix_ogcsad_c2c3c4`
	ON `service_account_datasets`(`google_cloud_service_account_id`, `google_cloud_role_id`, `google_bigquery_dataset_id`)
GO
CREATE UNIQUE INDEX `uix_odt_c2`
	ON `teams`(`team_name` DESC)
GO
