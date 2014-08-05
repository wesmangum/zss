RSpec.describe "Viewing the skill details" do
  let!(:training_path){ TrainingPath.create(name: "Hand-to-Hand Combat") }

  context "a skill that is in the list" do
    let(:output){ run_zss_with_input('1', '1') } # Hand-to-Hand Combat, with Scissors

    before do
      Skill.create(name: "with Scissors", training_path: training_path, description: "This is unsafe")
      Skill.create(name: "like a Zombie", training_path: training_path, description: "without being a Zombie")
    end

    it "should include the name of the skill being viewed" do
      expect(output).to include("Hand-to-Hand Combat: with Scissors")
    end
    it "should include the description of the skill being viewed" do
      expect(output).to include("This is unsafe")
    end
    it "shouldn't list the other skill descriptions" do
      expect(output).not_to include("without being a Zombie")
    end
  end

  context "if we enter a skill the doesn't exist" do
    before do
      training_path = TrainingPath.create(name: "Running")
      Skill.create(name: "with Scissors", training_path: training_path, description: "This is unsafe")
    end

    let(:output){ run_zss_with_input('1', '2') }

    it "prints an error message" do
      expect(output).to include("Sorry, skill 2 doesn't exist.")
    end
  end
end

