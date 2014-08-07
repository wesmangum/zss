RSpec.describe Achievement do
  it { should belong_to :skill }
  it { should validate_presence_of :mastered }
  it { should validate_presence_of :date }
end