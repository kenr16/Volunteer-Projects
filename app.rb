require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/projects")
require("./lib/volunteers")
require("pg")
require("pry")

DB = PG.connect({:dbname => "volunteer_tracker"})

get("/") do
  @projects = Project.all
  @floating_text = "Welcome to the projects homepage."
  erb(:index)
end

get("/hours") do
  @projects = Project.hours
  @floating_text = "Welcome to the projects homepage."
  erb(:index)
end

post("/projects") do
  project_name = params.fetch("project_name")
  new_project = Project.new({:id => nil, :name => project_name})
  new_project.save
  @projects = Project.all
  @floating_text = "Project Successfully Added."
  erb(:index)
end

get("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i)
  @floating_text = "Welcome to the #{@project.name} homepage."
  erb(:project)
end

patch("/projects/:id") do
  project_name = params.fetch("project_name")
  @project = Project.find(params.fetch("id").to_i)
  @project.update({:name => project_name})
  @floating_text = "Project successfully updated."
  erb(:project)
end

delete("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i)
  @project.delete
  @floating_text = "Project successfully deleted."
  @projects = Project.all
  erb(:index)
end

post("/volunteers/new") do
  project_id = params.fetch("project_id").to_i
  volunteer_name = params.fetch("volunteer_name")
  @new_volunteer = Volunteer.new({:id => 1, :name => volunteer_name, :project_id => project_id, :hours => 0})
  @new_volunteer.save
  @project = Project.find(project_id)
  @floating_text = "Volunteer successfully added."
  erb(:project)
end

get("/volunteers/:id") do
  @volunteer = Volunteer.find(params.fetch("id").to_i)
  @floating_text = "#{@volunteer.name} file"
  @projects = Project.all
  erb(:volunteer)
end

patch("/volunteers/:id") do
  volunteer_name = params.fetch("volunteer_name")
  project_id = params.fetch("project_id").to_i
  hours = params.fetch("hours").to_i
  @volunteer = Volunteer.find(params.fetch("id").to_i)
  @volunteer.update({:name => volunteer_name, :project_id => project_id, :hours => hours})
  @volunteer.add_hours(hours)
  @floating_text = "Volunteer info successfully updated."
  @projects = Project.all
  erb(:volunteer)
end

delete("/volunteers/:id") do
  @volunteer = Volunteer.find(params.fetch("id").to_i)
  @volunteer.delete
  @floating_text = "Volunteer successfully deleted."
  project_id = params.fetch("project_id").to_i
  @project = Project.find(project_id)
  erb(:project)
end

get("/volunteers") do
  @volunteers = Volunteer.all
  @floating_text = "Volunteer Employee Master File"
  @small_text = "sorted alphabetically"
  erb(:volunteers)
end

get("/volunteers_hours") do
  @volunteers = Volunteer.all_hours
  @floating_text = "Volunteer Employee Master File"
  @small_text = "sorted by hours worked"
  erb(:volunteers)
end

get("/search") do
  search_input = params.fetch('search_input')
  if Project.search(search_input) != nil
    id = Project.search(search_input)
    @project = Project.find(id)
    @floating_text = "Welcome to the #{@project.name} homepage."
    erb(:project)
  elsif Volunteer.search(search_input) != nil
    id = Volunteer.search(search_input)
    @volunteer = Volunteer.find(id)
    @floating_text = "#{@volunteer.name} file"
    @projects = Project.all
    erb(:volunteer)
  else
    @projects = Project.all
    @floating_text = "Entry not found in the database!"
    erb(:index)
  end
end
