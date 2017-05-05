class Project
  attr_accessor(:id, :name)

  def initialize (attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

  def ==(another_project)
    self.name.==(another_project.name).&(self.id.==(another_project.id))
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects")
    projects = []
    returned_projects.each do |project|
      id = project.fetch("id").to_i
      name = project.fetch("name")
      projects.push(Project.new({:id => id, :name => name}))
    end
    projects.sort! { |a,b| a.name.downcase <=> b.name.downcase }
  end

  def self.hours
    Project.all.sort! { |a,b| b.hours_worked <=> a.hours_worked }
  end

  def save
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.find(project_id)
    found_project = nil
    Project.all.each { |project|
      if project.id == project_id
        found_project = project
      end
    }
    found_project
  end

  def volunteers
    found_volunteers = []
    Volunteer.all.each { |volunteer|
      if volunteer.project_id == self.id
        found_volunteers.push(volunteer)
      end
    }
    found_volunteers.sort! { |a,b| a.name.downcase <=> b.name.downcase }
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    @id = self.id
    DB.exec("UPDATE projects SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{self.id};")
    DB.exec("DELETE FROM volunteers WHERE project_id = #{self.id()};")
  end

  def self.search(name)
    found_project = DB.exec("SELECT * FROM projects WHERE LOWER(name) = LOWER('#{name}');")
    id = nil
    found_project.each do |project|
      id = project.fetch("id").to_i
    end
    id
  end

  def hours_worked
    total_hours = 0
    self.volunteers.each do |volunteer|
      total_hours = total_hours += volunteer.hours.to_i
    end
    total_hours
  end
end
