require 'csv'
require_relative '../app/models/skill'
require_relative '../app/models/training_path'
require_relative '../lib/environment'

Environment.environment = "development"
source = "data/zombie_apocalypse.csv"

CSV.foreach(source, headers: true) do |row|
  training_path_name = row['trainin pth']
  skill_name = row['skillz']
  skill_description = row['descriqtion']

  training_path = TrainingPath.all.find{ |training_path| training_path.name == training_path_name }
  training_path ||= TrainingPath.create(name: training_path_name)
  Skill.create(name: skill_name, description: skill_description, training_path: training_path)
  puts "Imported #{skill_name} into #{training_path_name} with description #{skill_description}."
end
