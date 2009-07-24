# Basic requires
require 'rubygems'
require 'java'
require 'jdbc/hsqldb'

# Our requires
require 'event'
require 'hibernate'

# Point at config file
Hibernate.config = "rails_underground.cfg.xml"

Hibernate.tx do |session|
  # Hack for HSQLDB's write delay
  session.createSQLQuery("SET WRITE_DELAY FALSE").execute_update

  case ARGV[0]
  when /store/
    # Create event and store it
    event = Event.new
    event.title = ARGV[1]
    event.date = JDate.new
    
    session.save(event)
    puts "Stored!"
  when /list/
    # List all events
    list = session.create_query('from Event').list
    puts "Listing all events:"
    list.each do |evt|
      puts <<EOS
  id: #{evt.id}
    title: #{evt.title}
    date: #{evt.date}"
EOS
    end
  else
    puts "Usage:\n\tstore <title>\n\tlist"
  end
end