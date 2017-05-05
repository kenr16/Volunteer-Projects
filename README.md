
CREATE DATABASE volunteer_tracker;
CREATE TABLE "projects" (
"id"  SERIAL ,
"name" VARCHAR ,
PRIMARY KEY ("id")
);

CREATE TABLE "volunteers" (
"id"  SERIAL ,
"name" VARCHAR ,
"project_id" INTEGER ,
"hours" INTEGER ,
PRIMARY KEY ("id")
);

CREATE DATABASE volunteer_tracker_test WITH TEMPLATE volunteer_tracker;
