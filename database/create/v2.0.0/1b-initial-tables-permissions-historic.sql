DROP INDEX `uix_pha_c2` ON `actions`
GO
DROP INDEX `uix_gbdh_c2c4c8c9c10` ON `google_bigquery_datasets`
GO
ALTER TABLE `google_bigquery_datasets`
	DROP FOREIGN KEY `REL_36`
GO
DROP TABLE IF EXISTS `actions`
GO
DROP TABLE IF EXISTS `google_bigquery_datasets`
GO
CREATE TABLE `actions`  ( 
	`action_id`               	smallint AUTO_INCREMENT NOT NULL,
	`action_name`             	varchar(25) NOT NULL,
	`action_short_description`	varchar(500) NULL,
	PRIMARY KEY(`action_id`)
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
	`google_bigquery_dataset_history_action_id`           	smallint NOT NULL,
	`google_bigquery_dataset_history_datetime`            	datetime NOT NULL,
	`google_bigquery_dataset_history_user`                	varchar(100) NOT NULL,
	PRIMARY KEY(`google_bigquery_dataset_id`)
)
GO
ALTER TABLE `google_bigquery_datasets`
	ADD CONSTRAINT `REL_36`
	FOREIGN KEY(`google_bigquery_dataset_history_action_id`)
	REFERENCES `actions`(`action_id`)
GO
CREATE UNIQUE INDEX `uix_pha_c2`
	ON `actions`(`action_name`)
GO
CREATE UNIQUE INDEX `uix_gbdh_c2c4c8c9c10`
	ON `google_bigquery_datasets`(`google_cloud_project_id`, `google_bigquery_dataset_name`, `google_bigquery_dataset_history_action_id`, `google_bigquery_dataset_history_datetime`, `google_bigquery_dataset_history_user`)
GO
