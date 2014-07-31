RSpec.describe TrainingPath do
  context ".count" do
    it "returns 0 if there are no records" do
      expect(TrainingPath.count).to eql 0
    end
    it "returns the right number if there are records" do
      Environment.database.execute("INSERT INTO training_paths(name) VALUES('Foo')")
        # Expected table state:
        # | name |
        # -------
        # | Foo  |
      Environment.database.execute("INSERT INTO training_paths(name) VALUES('Bar')")
        # Expected table state:
        # | name |
        # -------
        # | Foo  |
        # | Bar  |
      expect(TrainingPath.count).to eql 2
    end
  end

  context ".create" do
    context "with valid data" do
      let!(:training_path){ TrainingPath.create(name: "Knife Skills") }
      it "should not have any errors" do
        expect(training_path.errors).to be_nil
      end
      it "should save the new record" do
        expect(TrainingPath.count).to eql 1
      end
      it "should have saved the values in that record" do
        actual = Environment.database.execute("SELECT name FROM training_paths")
        expected = [["Knife Skills"]]
        expect(actual).to eql expected
      end
      it "should record the id from the database" do
        actual = training_path.id
        expected = Environment.database.execute("SELECT id FROM training_paths")[0][0]
        expect(actual).to eql expected
      end
    end

    context "really long strings" do
      let(:long_string){ "foo" * 12 }
      let!(:training_path){ TrainingPath.create(name: long_string) }

      it "should have an appropriate error message" do
        expect(training_path.errors).to include("name must be less than 30 characters")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to eql 0
      end
    end

    context "empty string" do
      let!(:training_path){ TrainingPath.create(name: "") }

      it "should have an appropriate error message" do
        expect(training_path.errors).to include("Name cannot be blank")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to eql 0
      end
    end

    context "numbers" do
      let!(:training_path){ TrainingPath.create(name: "12") }

      it "should have an appropriate error message" do
        expect(training_path.errors).to include("Name must include letters")
      end
      it "shouldn't save the new record" do
        expect(TrainingPath.count).to eql 0
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
        expect(training_path2.errors).to include("A path with that name already exists")
      end

      it "shouldn't save the new record" do
        expect(TrainingPath.count).to eql 1
      end
    end
  end
  context ".last" do
    context "if there are no records" do
      it "should return nil" do
        expect(TrainingPath.last).to be_nil
      end
    end
    context "if there is one record" do
      let!(:training_path){ TrainingPath.create(name: "Blunt Weapon Skills") }

      it "should return a record, populated with the correct name" do
        expect(TrainingPath.last.name).to eql "Blunt Weapon Skills"
      end
      it "should return a record, populated with the correct id" do
        expect(TrainingPath.last.id).to eql training_path.id
      end
    end
    context "if there are several records" do
      let(:training_path1){ TrainingPath.create(name: "Foo") }
      let(:training_path2){ TrainingPath.create(name: "Bar") }

      before do
        training_path1
        training_path2
      end

      it "should return the record that was created last, populated with name" do
        expect(TrainingPath.last.name).to eql "Bar"
      end
      it "should return the record that was created last, populated with id" do
        expect(TrainingPath.last.id).to eql training_path2.id
      end
    end
  end
end
