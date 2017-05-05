class Volunteer
  attr_accessor(:id, :name, :project_id, :hours)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
  end

  define_method(:==) do |another_volunteer|
    self.name().==(another_volunteer.name()).&(self.id().==(another_volunteer.id())).&(self.project_id().==(another_volunteer.project_id()))
  end
end
