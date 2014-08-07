class SkillsController
  def initialize(origin_training_path)
    @origin_training_path = origin_training_path
  end

  def add
    puts "What #{@origin_training_path.name} skill do you want to add?"
    name = clean_gets
    skill = Skill.create(name: name, training_path: @origin_training_path)
    if skill.new_record?
      puts skill.errors.full_messages
    else
      puts "#{name} has been added to the #{@origin_training_path.name} training path"
    end
  end

  def list
    puts "=============="
    puts "#{@origin_training_path.name.upcase} SKILLS"
    puts "=============="
    skills.each_with_index do |skill, index|
      puts "#{index + 1}. #{skill.name}"
    end
    Router.navigate_skills_menu(self)
  end

  def view(path_number)
    skill = skills[path_number - 1]
    if skill
      puts "=============="
      puts "#{@origin_training_path.name}: #{skill.name}"
      puts skill.description
      AchievementsController.new().record(skill)
    else
      puts "Sorry, skill #{path_number} doesn't exist."
    end
  end

  private

  def skills
    @skills ||= @origin_training_path.skills
  end
end