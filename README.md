# Volunteer Projects Friday Project

#### _Ken Rutan's Volunteer Projects Database Ruby App, May 5th, 2017_

#### By _**Ken Rutan**_

## Overview

This website will allow the user to enter new volunteer projects into a database.  The project will also allow the user to select a volunteer project and add additional volunteers into the database as being assigned to that particular project.  In addition to the ability to add and view projects and volunteers, the user will also have the ability to modify and delete any projects or volunteers as well.  You may visit the project at the following link:
- Github: https://github.com/kenr16/Volunteer-Projects

## Objective

The objective here was to create a PostgreSQL Database that would hold tables of a specific design.  From there, ruby object would be created that would correspond in form to the database tables in a way that allowed for rapid and easy modification of the database tables without specifically referencing individual values each time.  A program called 'PG' is used as the go-between which allows the transfer of data between the database and the ruby framework.

## Specifications

| behavior |  input   |  output  |
|----------|:--------:|:--------:|
|Create an object class corresponding to the 'projects' table in the database.|*ID*, *name*|[1, "Database Design"]|
|Create an object class corresponding to the 'volunteers' table in the database.|*ID*, *name*, *project_id*, *hours*|[5, "John Doe", 1, 115]|
|Allow the user to find a project corresponding to a specific ID|Project.find(1)|"Database Design"|
|Allow the user to find a volunteer corresponding to a specific ID|Volunteer.find(5)|"John Doe"|
|Establish the many-to-one relationship by finding all volunteers assigned to a project|"Database Design".volunteers()|"John Doe"|
|Allow various sorting methods to be implemented on the website display|.alphabetize()|["Amy", "Ben", "Clara", "Dave", "Everet"]|

## Installation

* In order to run this app:
  - Locate the git repository of this project.
  - Clone or download the git repository onto your desktop.
  - Create the required database from the instructions listed below.
  - Locate home folder of the app "ie:/volunteer_tracker/"
  - Once you have navigated into this folder, run "ruby app.rb" which should open Sinatra.
  - It should open when you navigate to localhost:4567 in the browser of your choice.

## Database Creation

From the command line, run 'postgres'.  Open up an new window or tab in the command line and run 'psql'.  The following commands are necessary to create the required database, and they can be typed in as they appear here:

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

## Usage

Input a a new project and click "Add Project" to get started creating your first project!  From there you can click on the project to be linked to its homepage and begin adding volunteers to the project.  Once volunteers have been added to the project, you can click on their names to be redirected to their homepage, where they can be modified, deleted, etc.  Projects can also be modified in this manor.

## Known Bugs
There are currently no known bugs in these HTML, CSS, Bootstrap, Ruby, Sinatra or PostgreSQL files.

## Support and contact details

For further support, please contact Ken Rutan through his Github account. E-mail will not be listed here as this README is publicly displayed.

##Technologies Used

This website was constructed using HTML, CSS and Ruby as well as Sinatra and PostgreSQL elements.

## License

Copyright (c) 2017 Ken Rutan.  This software is licensed under the MIT License.
