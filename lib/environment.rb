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

  def self.database
    unless @database
      @database = SQLite3::Database.open("db/#{@@environment}.sqlite")
      @database.execute "CREATE TABLE IF NOT EXISTS training_paths(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(29))"
      @database.execute "CREATE TABLE IF NOT EXISTS skills(id INTEGER PRIMARY KEY AUTOINCREMENT, training_path_id INTEGER, name VARCHAR(29))"

      results = @database.execute "PRAGMA table_info(skills);"
      unless results.find{ |row| row[1] == "description" }
        @database.execute "ALTER TABLE skills ADD COLUMN description text"
      end
    end
    @database
  end
end
