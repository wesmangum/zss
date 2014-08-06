class CreateSkills < ActiveRecord::Migration
  def change
    # In our original implementation:
    # CREATE TABLE IF NOT EXISTS skills(id INTEGER PRIMARY KEY AUTOINCREMENT, training_path_id INTEGER, name VARCHAR(29))
    create_table :skills do |t|
      t.string :name
      # Old School: t.integer :training_path_id
      # New School:
      t.references :training_path
    end
  end
end
