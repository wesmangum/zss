RSpec.describe "Marking the skill as achieved or not", :integration do
  let!(:path1){ TrainingPath.create(name: "Weapons") }
  let!(:path2){ TrainingPath.create(name: "Insults") }

  context "a skill that has not previously been mastered" do
    let(:output_yes){ run_zss_with_input('2', '2', 'y') } # Insults > Name Calling
    let(:output_no){ run_zss_with_input('2', '2', 'n') } # Insults > Name Calling

    let!(:skill1){ Skill.create(name: "Cursing", training_path: path2, description: "Bring out the inner sailor") }
    let!(:skill2){ Skill.create(name: "Name Calling", training_path: path2, description: "Bring out the shame") }

    context "marking as mastered" do
      before do
        output_yes
      end
      it "should ask the user if they have achieved the skill yet" do
        expect(output_yes).to include("Mark as achieved? y/n")
      end

      it "should print a congratulatory message" do
        expect(output_yes).to include("Congrats, you've mastered Name Calling!")
      end

      it "should save a new achievement for that skill" do
        skill2.achievement.mastered.should be_truthy
      end

      context "and viewing the skill again" do
        let(:output_view){ run_zss_with_input('2', '2') }
        before do
          output_view
        end
        it "should congratulate me for knowing this already" do
          expect(output_view).to include("Congrats! You already knew this!")
        end
        it "should not ask the user if they have achieved the skill yet" do
          expect(output_view).not_to include("Mark as achieved? y/n")
        end
        it "should print a correct congratulatory message" do
          pending "time travel"
          expect(output_view).to include("You mastered this skill on August 14th")
        end
      end
    end

    context "marking as not mastered" do
      before do
        output_no
      end
      it "should ask the user if they have achieved the skill yet" do
        expect(output_no).to include("Mark as achieved? y/n")
      end

      it "should print a insulting message" do
        expect(output_no).to include("Really?! All you had to do was read this paragraph. Would you agree with that?")
      end

      it "should save a new achievement for that skill" do
        skill2.achievement.mastered.should be_falsey
      end

      context "then updating it to mark it as mastered" do
        let(:output_updated){ run_zss_with_input('2', '2', 'y') }
        it "should ask the user if they have achieved the skill yet" do
          expect(output_updated).to include("Mark as achieved? y/n")
        end

        it "should print a congratulatory message" do
          expect(output_updated).to include("Congrats, you've mastered Name Calling!")
        end

        it "should be updating the existing achievement record" do
          pending "Figuring out what's wrong"
          achievement = skill2.achievement
          output_updated
          achievement.reload
          achievement.mastered.should be_truthy
        end

        it "doesn't create an extra achievement record" do
          expect{ output_updated }.not_to change{ Achievement.count }
          # Equivalent to:
          # original_count = Achievement.count
          # output_updated
          # Achievement.count.should == original_count
        end
      end
    end
  end
end