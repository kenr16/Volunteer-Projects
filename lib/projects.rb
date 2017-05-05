class Project
  attr_accessor(:id, :name)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

  define_method(:==) do |another_project|
    self.name.==(another_project.name).&(self.id.==(another_project.id))
  end

  define_singleton_method(:all) do
    returned_projects = DB.exec("SELECT * FROM projects")
    projects = []
    returned_projects.each do |project|
      id = project.fetch("id").to_i
      name = project.fetch("name")
      projects.push(Project.new({:id => id, :name => name}))
    end
    projects.sort! { |a,b| a.name.downcase <=> b.name.downcase }
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  define_singleton_method(:find) do |project_id|
    found_project = nil
    Project.all.each do |project|
      if project.id == project_id
        found_project = project
      end
    end
    found_project
  end

  define_method(:volunteers) do
    found_volunteers = []
    Volunteer.all.each do |volunteer|
      if volunteer.project_id == self.id
        found_volunteers.push(volunteer)
      end
    end
    found_volunteers.sort! { |a,b| a.name.downcase <=> b.name.downcase }
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id
    DB.exec("UPDATE projects SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM projects WHERE id = #{self.id};")
    DB.exec("DELETE FROM volunteers WHERE project_id = #{self.id()};")
  end

  define_singleton_method(:search) do |name|
    found_project = DB.exec("SELECT * FROM projects WHERE name = '#{name}';")
    projects = []
    found_project.each do |project|
      id = project.fetch("id").to_i
      name = project.fetch("name")
      projects.push(Project.new({:id => id, :name => name}))
    end
    projects
  end

end
