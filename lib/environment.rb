require 'sqlite3'

class Environment
  def self.database
    unless @database
      @database = SQLite3::Database.open("db/test.sqlite")
      @database.execute "CREATE TABLE IF NOT EXISTS training_paths(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(29))"
    end
    @database
  end
end
