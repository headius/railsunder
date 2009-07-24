require 'jruby'
require 'jruby/core_ext'
require 'java'

class Event
  attr_accessor :id, :title, :date
end

#### From here down we'd want to eliminate ###

# Alias some Java types
JClass = java.lang.Class
JString = java.lang.String
JLong = java.lang.Long
JDate = java.util.Date
JVoid = java.lang.Void::TYPE

# Add method names Java recognizes (Yuck!)
class Event
  alias getId id
  alias setId id=
  alias getTitle title
  alias setTitle title=
  alias getDate date
  alias setDate date=
end

# Add Java signatures (Heinous!)
E = JRuby.reference(Event)
E.add_method_signature "getId",
  [JLong.java_class].to_java(JClass)
E.add_method_signature "setId",
  [JVoid, JLong.java_class].to_java(JClass)
E.add_method_signature "getTitle",
  [JString.java_class].to_java(JClass)
E.add_method_signature "setTitle",
  [JVoid, JString.java_class].to_java(JClass)
E.add_method_signature "getDate",
  [JDate.java_class].to_java(JClass)
E.add_method_signature "setDate",
  [JVoid, JDate.java_class].to_java(JClass)

# Become Java!
Event.become_java!

__END__
# Possible future syntax?
class Event
  include Hibernate::Model
  
  jibernate_attr(
    :id => :long,
    :title => :string,
    :date => :date)
end
