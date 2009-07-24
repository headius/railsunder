require 'java'
$: << File.join(File.dirname(__FILE__),
  "hibernate-distribution-3.3.2.GA")
require 'lib/required/antlr-2.7.6.jar'
require 'lib/required/commons-collections-3.1.jar'
require 'lib/required/dom4j-1.6.1.jar'
require 'lib/required/javassist-3.9.0.GA.jar'
require 'lib/required/jta-1.1.jar'
require 'slf4j-1.5.8/slf4j-simple-1.5.8.jar'
require 'slf4j-1.5.8/slf4j-api-1.5.8.jar'
require 'hibernate3.jar'

module Hibernate
  import org.hibernate.cfg.Configuration

  def self.tx
    session.begin_transaction
    if block_given?
      yield session
      session.transaction.commit
    end
  end

  def self.factory
    config = Configuration.new
    if @filename
      config.configure @filename
    else
      config.configure
    end
    @factory ||= config.build_session_factory
  end

  def self.session
    factory.current_session
  end

  def self.config=(filename)
    @filename = filename
  end
end
