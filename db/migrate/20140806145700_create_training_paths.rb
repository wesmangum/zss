class CreateTrainingPaths < ActiveRecord::Migration
  def change
    # In our original implementation we used:
    # "CREATE TABLE IF NOT EXISTS training_paths(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(29))"
    create_table :training_paths do |t|
      t.string :name
    end
  end
end
