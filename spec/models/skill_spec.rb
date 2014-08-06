RSpec.describe Skill do
  it { should belong_to :training_path }
  it { should validate_presence_of :name }
  it { should validate_presence_of :training_path }
end
