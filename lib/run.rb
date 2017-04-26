# class Venue
#   @@id = 0
#   def initialize name="Venue #{@@id}"
#     @@id += 1
#   end

#   include PreparerRole
# end

# class Invoice

# end


module PreparerRole
  def prepare
    raise NotImplementedError, 'The role of preparer is incomplete because method prepareis not implemented'
  end
end

class Manager
  include PreparerRole

  attr_reader :name

  def initialize args
    @name = args[:name]
  end

  def prepare_experience experience_class
    experience_class.new args
  end

  def prepare preparable
    preparable.get_prepared_by
  end
end

module PreparableRole
  def get_prepared_by preparer
    preparer.prepare self
  end
end

class Package
  include PreparableRole

  attr_accessor :num_of_people
  attr_reader :cost_per_person, :managers_name

  def initialize args=({})
    @num_of_people = args[:num_of_people] || default_num_of_people
    @cost_per_person = args[:cost_per_person] || default_cost_per_person
    @managers_name = nil

    after_initialize args
  end

  def after_initialize args
    nil
  end

  def cost
    num_of_people * cost_per_person
  end

  def default_num_of_people
    raise NotImplementedError
  end

  def default_cost_per_person
    raise NotImplementedError
  end

  def survey_attendees attendees
    count = 0
    attendees.each do |attendee|
      count += 1
    end
    count
  end
end

class OnlineExperience < Package
  attr_reader :event_ip_address, :attendees

  def add_attendee
    @attendees
  end

  def after_initialize(args={})
    @event_ip_address = args[:event_ip_address] || raise(NotImplementedError, "args[:event_ip_address] not supplied")
    @attendees = args[:attendees] || []
  end

  def default_num_of_people
    5
  end

  def default_cost_per_person
    5
  end
end

class EventExperience < Package
  attr_reader :location

  def after_initialize args
    @location = args[:location]
  end

  def default_num_of_people
    10
  end

  def default_cost_per_person
    25
  end
end

class People
  attr_reader :age, :fun_status, :name

  def initialize args
    @name = args[:name]
    @age = args[:age]
    @fun_status = true
  end
end




 # e = EventExperience.new( { location: 'here' } )
 # o = OnlineExperience.new( { event_ip_address: '192.168.0.1' } )
