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
      project = Project.new({:id => 1, :name => "POSTGRESQL database rework"})
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
      project = Project.new({:id => 1, :name => "POSTGRESQL database rework"})
      project.save
      expect(project.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe(".find") do
    it("returns a project by its ID") do
      project1 = Project.new({:id => 1, :name => "POSTGRESQL database rework"})
      project1.save
      project2 = Project.new({:id => 2, :name => "RESTFUL routing rename"})
      project2.save
      expect(Project.find(project2.id)).to(eq(project2))
    end
  end

end
