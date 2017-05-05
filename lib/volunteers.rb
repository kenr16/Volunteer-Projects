class Volunteer
  attr_accessor(:id, :name, :project_id, :hours)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @hours = attributes.fetch(:hours)
  end

  define_method(:==) do |another_volunteer|
    self.name.==(another_volunteer.name).&(self.id.==(another_volunteer.id)).&(self.project_id.==(another_volunteer.project_id))
  end

  define_singleton_method(:all) do
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    returned_volunteers.each do |volunteer|
      id = volunteer.fetch("id").to_i
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id").to_i
      hours = volunteer.fetch("hours").to_i
      volunteers.push(Volunteer.new({:id => id, :name => name, :project_id => project_id, :hours => hours}))
    end
    volunteers.sort! { |a,b| a.name.downcase <=> b.name.downcase }
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO volunteers (id, name, project_id, hours) VALUES (#{@id}, '#{@name}', #{@project_id}, #{@hours}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:update) do |attributes|
    @id = self.id()
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @hours = attributes.fetch(:hours)
    DB.exec("UPDATE volunteers SET (name, project_id, hours) = ('#{@name}', #{@project_id}, #{@hours}) WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM volunteers WHERE id = #{self.id()};")
  end



end
