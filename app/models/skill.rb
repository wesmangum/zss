class Skill < ActiveRecord::Base
  belongs_to :training_path

  validates_presence_of :name, :training_path
end
