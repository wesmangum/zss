require 'sqlite3'
require 'active_record'

Dir["./app/**/*.rb"].each { |f| require f }
I18n.enforce_available_locales = false

class Environment

  def self.environment=(environment)
    @@environment = environment
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details[@@environment])
  end
end
