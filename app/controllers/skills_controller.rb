class SkillsController
  def add(origin_training_path)
    puts "What skill do you want to add?"
    name = clean_gets
    skill = Skill.create(name: name, training_path: origin_training_path)
    if skill.new_record?
      puts skill.errors
    else
      puts "#{name} has been added to the #{origin_training_path.name} training path"
    end
  end
end
