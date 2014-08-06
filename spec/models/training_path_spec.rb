RSpec.describe TrainingPath do
  context "validations" do
    it { should have_many :skills }
    it { should ensure_length_of(:name).
         is_at_most(30).
         with_message("must be less than 30 characters") }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).
          with_message("already exists") }

    context "validating format" do
      let!(:training_path){ TrainingPath.create(name: "12") }

      it "should have an appropriate error message" do
        expect(training_path.errors.full_messages_for(:name)
              ).to include("Name must include letters")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to eq 0
      end
    end
  end
end
