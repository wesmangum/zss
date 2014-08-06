RSpec.describe TrainingPath do
  context "validations" do
    context "with valid data" do
      let!(:training_path){ TrainingPath.create(name: "Knife Skills") }
      it "should not have any errors" do
        expect(training_path.errors).to be_empty
        # Typically we would use: `expect(training_path).to be_valid`
      end
      it "should save the new record" do
        expect(TrainingPath.count).to eq 1
      end
      it "should have saved the values in that record" do
        actual = TrainingPath.last
        expect(actual).to eq training_path
      end
    end

    context "really long strings" do
      let(:long_string){ "foo" * 12 }
      let!(:training_path){ TrainingPath.create(name: long_string) }

      it "should have an appropriate error message" do
        expect(training_path.errors.full_messages_for(:name)
              ).to include("Name must be less than 30 characters")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to eq 0
      end
    end

    context "empty string" do
      let!(:training_path){ TrainingPath.create(name: "") }

      it "should have an appropriate error message" do
        expect(training_path.errors.full_messages_for(:name)
              ).to include("Name can't be blank")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to eq 0
      end
    end

    context "numbers" do
      let!(:training_path){ TrainingPath.create(name: "12") }

      it "should have an appropriate error message" do
        expect(training_path.errors.full_messages_for(:name)
              ).to include("Name must include letters")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to eq 0
      end
    end

    context "a duplicate path name" do
      let(:training_path1){ TrainingPath.create(name: "Running") }
      let(:training_path2){ TrainingPath.create(name: "Running") }

      before do
        training_path1
        training_path2
      end

      it "should have an appropriate error message" do
        expect(training_path2.errors.full_messages_for(:name)
              ).to include("Name already exists")
      end

      it "shouldn't save the new record" do
        expect(TrainingPath.count).to eq 1
      end
    end
  end
  context "#skills" do
    let!(:my_training_path){ TrainingPath.create(name: "Awesome") }
    let!(:other_training_path){ TrainingPath.create(name: "Weevil") }

    context "if there no skills at all" do
      it "returns an empty array" do
        result = my_training_path.skills
        result.should == []
      end
    end
    context "if there are no skills for this training path" do
      before do
        Skill.create(name: "someone else", training_path: other_training_path)
        Skill.create(name: "someone", training_path: other_training_path)
      end
      it "returns an empty array" do
        result = my_training_path.skills
        result.should == []
      end
    end
    context "if there are many skills" do
      let!(:myskill1){ Skill.create(name: "mine!", training_path: my_training_path) }
      let!(:myskill2){ Skill.create(name: "really mine!", training_path: my_training_path) }
      let!(:myskill3){ Skill.create(name: "all mine!", training_path: my_training_path) }

      before do
        Skill.create(name: "someone else", training_path: other_training_path)
        Skill.create(name: "someone", training_path: other_training_path)
      end

      it "returns an the skills for this path" do
        result = my_training_path.skills
        result.should == [myskill1, myskill2, myskill3]
      end
    end
  end
end
