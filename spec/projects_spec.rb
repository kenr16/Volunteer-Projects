require("spec_helper")


describe("Project") do

  describe("#==") do
    it("is the same projects if it has the same name and id") do
      project1 = Project.new({:id => 1, :name => "POSTGRESQL database rework"})
      project2 = Project.new({:id => 1, :name => "POSTGRESQL database rework"})
      expect(project1).to(eq(project2))
    end
  end

  describe(".all") do
    it("starts off with no projects") do
      expect(Project.all).to(eq([]))
    end
  end

  describe("#save") do
    it("lets you save the projects to the database") do
      project = Project.new({:id => nil, :name => "POSTGRESQL database rework"})
      project.save()
      expect(Project.all).to(eq([project]))
    end
  end

  describe("#name") do
    it("tells you the project name") do
      project = Project.new({:id => 1, :name => "POSTGRESQL database rework"})
      expect(project.name()).to(eq("POSTGRESQL database rework"))
    end
  end

  describe("#id") do
    it("sets project ID when you save it") do
      project = Project.new({:id => nil, :name => "POSTGRESQL database rework"})
      project.save
      expect(project.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe(".find") do
    it("returns a project by its ID") do
      project1 = Project.new({:id => nil, :name => "POSTGRESQL database rework"})
      project1.save
      project2 = Project.new({:id => nil, :name => "Design RESTFUL routing"})
      project2.save
      expect(Project.find(project2.id)).to(eq(project2))
    end
  end

  describe("#volunteers") do
    it("returns an array of volunteers assigned to that project") do
      project1 = Project.new({:id => nil, :name => "POSTGRESQL database rework"})
      project1.save
      volunteer1 = Volunteer.new({:id => nil,:name => "John Murdocks", :project_id => project1.id, :hours => 6})
      volunteer1.save
      volunteer2 = Volunteer.new({:id => nil,:name => "Jane Rosemary", :project_id => project1.id, :hours => 5})
      volunteer2.save
      expect(project1.volunteers).to(eq([volunteer2, volunteer1]))
    end
  end

  describe("#update") do
    it("lets you update projects in the database") do
      project = Project.new({:id => nil, :name => "POSTGRESQL database rework"})
      project.save
      project.update({:name => "Design Front End UX"})
      expect(project.name()).to(eq("Design Front End UX"))
    end
  end

  describe("#delete") do
    it("lets you delete a project from the database") do
      project1 = Project.new({:id => nil, :name => "POSTGRESQL database rework"})
      project1.save
      project2 = Project.new({:id => nil, :name => "Design RESTFUL routing"})
      project2.save
      project1.delete
      expect(Project.all).to(eq([project2]))
    end

    it("deletes a project's volunteers from the database") do
      project1 = Project.new({:id => nil, :name => "POSTGRESQL database rework"})
      project1.save
      volunteer1 = Volunteer.new({:id => nil,:name => "John Murdocks", :project_id => project1.id, :hours => 6})
      volunteer1.save
      volunteer2 = Volunteer.new({:id => nil,:name => "Jane Rosemary", :project_id => project1.id, :hours => 5})
      volunteer2.save
      project1.delete
      expect(Project.all).to(eq([]))
    end
  end

  describe(".search") do
    it("lets you search the database of projects for one with a matching name") do
      project1 = Project.new({:id => nil, :name => "Test Project 1"})
      project1.save
      project2 = Project.new({:id => nil, :name => "Test Project 2"})
      project2.save
      expect(Project.search("Test Project 1")).to(eq(project1.id))
    end
  end

end
