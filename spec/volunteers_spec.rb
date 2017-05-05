require("spec_helper")

describe(Volunteer) do
  describe('#==') do
    it("is the same volunteer if it has the same name and ID number") do
      volunteer1 = Volunteer.new({:id => 1,:name => "Murdocks", :project_id => 1, :hours => 5})
      volunteer2 = Volunteer.new({:id => 1,:name => "Murdocks", :project_id => 1, :hours => 5})
      expect(volunteer1==volunteer2).to(eq(true))
    end
  end

  describe(".all") do
    it("is empty at first") do
      expect(Volunteer.all()).to(eq([]))
    end
  end

  describe('#save') do
    it("adds a volunteer to the array of saved volunteers") do
      test_volunteer = Volunteer.new({:id => nil,:name => "Murdocks", :project_id => 1, :hours => 5})
      test_volunteer.save()
      expect(Volunteer.all()).to(eq([test_volunteer]))
    end
  end

  describe("#id") do
    it("sets volunteer's ID when you save it") do
      volunteer1 = Volunteer.new({:id => nil,:name => "John Murdocks", :project_id => 1, :hours => 6})
      volunteer1.save
      expect(volunteer1.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#name') do
    it("lets you view the volunteer's name") do
      test_volunteer =  Volunteer.new({:id => 1,:name => "Murdocks", :project_id => 1, :hours => 5})
      expect(test_volunteer.name()).to(eq("Murdocks"))
    end
  end

  describe('#project_id') do
    it("lets you view the volunteers's project id") do
      test_volunteer = Volunteer.new({:id => 1,:name => "Murdocks", :project_id => 1, :hours => 5})
      expect(test_volunteer.project_id).to(eq(1))
    end
  end

  describe('#hours') do
    it("lets you view the volunteer's worked hours") do
      test_volunteer =  Volunteer.new({:id => 1,:name => "Murdocks", :project_id => 1, :hours => 5})
      expect(test_volunteer.hours).to(eq(5))
    end
  end

  describe("#update") do
    it("lets you update information on the volunteer") do
      test_volunteer =  Volunteer.new({:id => nil,:name => "Murdocks", :project_id => 1, :hours => 5})
      test_volunteer.save
      test_volunteer.update({:name => "John Murdocks", :project_id => 2, :hours => 10})
      expect(test_volunteer.name).to(eq("John Murdocks"))
      expect(test_volunteer.project_id).to(eq(2))
      expect(test_volunteer.hours).to(eq(10))
    end
  end

  describe("#delete") do
    it("lets you delete a volunteer from the database") do
      volunteer1 = Volunteer.new({:id => nil,:name => "John Murdocks", :project_id => 1, :hours => 6})
      volunteer1.save
      volunteer2 = Volunteer.new({:id => nil,:name => "Jane Rosemary", :project_id => 1, :hours => 5})
      volunteer2.save
      volunteer1.delete
      expect(Volunteer.all).to(eq([volunteer2]))
    end
  end




end
