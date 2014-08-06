RSpec.describe Skill do
  let(:training_path){ TrainingPath.create(name: "Blending In") }
  context "validations" do
    context "with valid data" do
      let!(:skill){ Skill.create(name: "Shuffling", description: "Like running with your feet on the ground", training_path: training_path) }
      it "should have no errors" do
        expect(skill.errors).to be_empty
      end
      it "should save the record accurately" do
        actual = Skill.last
        expect(actual).to eq skill
      end
    end
    context "without a training path" do
      let!(:skill){ Skill.create(name: "Shuffling", description: "Foo", training_path: nil) }
      it "should have an error message" do
        expect(skill.errors.full_messages_for(:training_path)
              ).to include("Training path can't be blank")
      end
      it "should not save to the database" do
        expect(Skill.count).to eq 0
      end
    end
    context "with a blank name" do
      let!(:skill){ Skill.create(name: "", description: "Foo", training_path: training_path) }
      it "should have an error message" do
        expect(skill.errors.full_messages_for(:name)
              ).to include("Name can't be blank")
      end
      it "should not save to the database" do
        expect(Skill.count).to eq 0
      end
    end
  end
end
