require("spec_helper")

describe(Volunteer) do
  describe('#==') do
    it("is the same volunteer if it has the same name and ID number") do
      volunteer1 = Volunteer.new({:id => 1,:name => "Mark Jones", :project_id => 1, :hours => 5})
      volunteer2 = Volunteer.new({:id => 1,:name => "Mark Jones", :project_id => 1, :hours => 5})
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
      test_volunteer = Volunteer.new({:id => 1,:name => "Mark Jones", :project_id => 1, :hours => 5})
      test_volunteer.save()
      expect(Volunteer.all()).to(eq([test_volunteer]))
    end
  end


end
