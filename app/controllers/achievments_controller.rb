class AchievementsController
  def record(skill)
    if skill.mastered?
      puts "Congrats! You already knew this!"
    else
      achievement = skill.achievement || skill.build_achievement
      puts "Mark as achieved? y/n"
      command = clean_gets
      if command.start_with? 'y'
        achievement.mastered = true
        puts "Congrats, you've mastered #{skill.name}!"
      else
        achievement.mastered = false
        puts "Really?! All you had to do was read this paragraph. Would you agree with that?"
      end
      skill.save!
    end
  end
end