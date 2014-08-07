class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.references :skill
      t.boolean :mastered
      t.timestamps
    end
  end
end