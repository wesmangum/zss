class Skill < ActiveRecord::Base
  belongs_to :training_path
  has_one :achievement

  validates_presence_of :name, :training_path
end
