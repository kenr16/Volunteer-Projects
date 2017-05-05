class Volunteer
  attr_accessor(:id, :name, :project_id, :hours)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @hours = attributes.fetch(:hours)
  end

  def ==(another_volunteer)
    self.name.==(another_volunteer.name).&(self.id.==(another_volunteer.id)).&(self.project_id.==(another_volunteer.project_id))
  end

  def self.all
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

  def self.all_hours
    Volunteer.all.sort! { |a,b| b.hours <=> a.hours}
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, project_id, hours) VALUES ('#{@name}', #{@project_id}, #{@hours}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.find(volunteer_id)
    found_volunteer = nil
    Volunteer.all.each { |volunteer|
      if volunteer.id == volunteer_id
        found_volunteer = volunteer
      end
    }
    found_volunteer
  end

  def update(attributes)
    @id = self.id
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    DB.exec("UPDATE volunteers SET (name, project_id) = ('#{@name}', #{@project_id}) WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{self.id()};")
  end

  def add_hours(hours)
    @hours = self.hours.to_i + hours.to_i
    @id = self.id
    DB.exec("UPDATE volunteers SET (hours) = (#{@hours}) WHERE id = #{@id};")
  end

  # There has got to be a better way for extracting information from a singlular PG return packet than a .each loop.

  def self.search(name)
    found_volunteer = DB.exec("SELECT * FROM volunteers WHERE LOWER(name) = LOWER('#{name}');")
    id = nil
    found_volunteer.each { |volunteer| id = volunteer.fetch("id").to_i }
    id
  end

end
