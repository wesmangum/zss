RSpec.describe TrainingPath do
  context ".create" do
    context "really long strings" do
      let(:long_string){ "foo" * 12 }
      let!(:training_path){ TrainingPath.create(name: long_string) }

      it "should print an appropriate error message" do
        expect(training_path.errors).to include("name must be less than 30 characters")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to == 0
      end
    end

    context "empty string" do
      let!(:training_path){ TrainingPath.create(name: "") }

      it "should print an appropriate error message" do
        expect(training_path.errors).to include("Name cannot be blank")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to == 0
      end
    end

    context "numbers" do
      let!(:training_path){ TrainingPath.create(name: "12") }

      it "should print an appropriate error message" do
        expect(training_path.errors).to include("Name must include letters")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to == 0
      end
    end

    context "a duplicate path name" do
      let(:training_path1){ TrainingPath.create(name: "Running") }
      let(:training_path2){ TrainingPath.create(name: "Running") }

      before do
        training_path1
        training_path2
      end

      it "should print an appropriate error message" do
        expect(training_path2.errors).to include("A path with that name already exists")
      end

      it "shouldn't save the new record" do
        expect(TrainingPath.count).to == 1
      end
    end
  end
end
