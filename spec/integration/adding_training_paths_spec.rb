RSpec.describe "Adding training paths" do
  context "valid input" do
    before do
      run_zss_with_input("add", "Sneaking")
    end
    it "should add a record" do
      expect(TrainingPath.count).to == 1
    end
    it "should save the record accurately" do
      expect(TrainingPath.last.name).to == "Sneaking"
    end
    it "should print a success message" do
      expect(output).to include("Sneaking has been added to the list of training paths")
    end
  end
  context "invalid input" do
    context "really long strings" do
      before do
        long_string = "foo" * 12
        run_zss_with_input("add", long_string)
      end
      it "should print an appropriate error message" do
        expect(output).to include("Name must be less than 30 characters")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to == 0
      end
    end
    context "empty input" do
      before do
        run_zss_with_input("add","")
      end
      it "should print an appropriate error message" do
        expect(output).to include("Name cannot be blank")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to == 0
      end
    end
    context "numbers" do
      before do
        run_zss_with_input("add","12")
      end
      it "should print an appropriate error message" do
        expect(output).to include("Name must include letters")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to == 0
      end
    end
    context "a duplicate path name" do
      before do
        TrainingPath.create(name: "Running")
        run_zss_with_input("add","Running")
      end
      it "should print an appropriate error message" do
        expect(output).to include("A path with that name already exists")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to == 1
      end
    end
  end
end
