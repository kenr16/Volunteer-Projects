require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new project', {:type => :feature}) do
  it('allows a user to add a new project to the webpage') do
    visit('/')
    fill_in('project_name', :with =>'Test Project 1')
    click_button('Add Project')
    expect(page).to have_content('Project Successfully Added.')
    expect(page).to have_content('Test Project 1')
  end
end

describe('viewing all of the projects', {:type => :feature}) do
  it('allows a user to see all of the projects that have been created') do
    project1 = Project.new({:id => nil, :name => 'Test Project 1'})
    project1.save
    project2 = Project.new({:id => nil, :name => 'Test Project 2'})
    project2.save
    visit('/')
    expect(page).to have_content('Test Project 1')
    expect(page).to have_content('Test Project 2')
  end
end

describe('modifying a project', {:type => :feature}) do
  it('allows a user to rename a specific project') do
    project1 = Project.new({:id => nil, :name => 'Test Project 1'})
    project1.save
    visit("/projects/#{project1.id()}")
    fill_in("project_name", {:with => "Renamed Test Project"})
    click_button("Update Project")
    expect(page).to have_content('Project successfully updated.')
    expect(page).to have_content('Renamed Test Project')
  end
end

describe('deleting a project', {:type => :feature}) do
  it('allows a user to remove a specific project from the database') do
    project1 = Project.new({:id => nil, :name => 'Test Project 1'})
    project1.save
    visit("/projects/#{project1.id()}")
    click_button("Delete Project")
    expect(page).to have_content('Project successfully deleted.')
  end
end


describe('seeing details for a single project', {:type => :feature}) do
  it('allows a user to click a project and see details for it') do
    project1 = Project.new({:id => nil, :name => 'Test Project 1'})
    project1.save
    volunteer1 = Volunteer.new({:id => nil,:name => "Test Volunteer 1", :project_id => project1.id, :hours => 6})
    volunteer1.save
    visit('/')
    click_link(project1.name)
    expect(page).to have_content(volunteer1.name)
  end
end

describe('adding volunteers to a project', {:type => :feature}) do
  it('allows a user to volunteers to a specific project') do
    project1 = Project.new({:id => nil, :name => 'Test Project 1'})
    project1.save
    visit("/projects/#{project1.id()}")
    fill_in("volunteer_name", {:with => "Test Volunteer"})
    click_button("Add Volunteer")
    expect(page).to have_content("Volunteer successfully added.")
    expect(page).to have_content("Test Volunteer")
  end
end
