## CREATE:
#### Stage 1: Create the main database model:
Use the file: _1-initial-tables.sql_ in _create_ from the maximum: vX.X.X folder

#### Stage 2: Seed the database for the known data (google):
Use the file found in _seed-data_ from the maximum: vX.X.X folder.

#### Stage 3: Seed the database with the initial organisational data:
Use the file found in _create_ -> _test-seed-data_ and run the database commands.

#### Stage 4: Create the denormalised views:
Use the file: 2-generate-denormalised-views.sql in _create_ from the maximum: vX.X.X folder to generate the functions
tables needed to create the code for the views. Use the output of the final statement to create the actual views.

#### Stage 5: Create the views and stored procedures to support the resources:
Use the files:
_2-generate-denormalised-views.sql_
_3-employee-resources.sql_
_4-group-resources.sql_
_5-job-resources.sql_
_6-org-dept-team-resources.sql_
_7-service-accounts-resources.sql_
found in _create_ from the maximum: vX.X.X folder to create the views and the stored procedures needed to create the 
resources in the datasets tables.

# TODO: Change the INSERT statements at the end of the files to actual SP's

 
