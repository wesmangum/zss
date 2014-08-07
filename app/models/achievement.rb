class Achievement < ActiveRecord::Base
  belongs_to :skill

  validates_presence_of :mastered, :date
end