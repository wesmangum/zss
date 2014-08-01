class Router
  def self.navigate_skills(training_path)
    clean_gets
    skills_controller = SkillsController.new()
    skills_controller.add(training_path)
  end

  def self.navigate_training_paths(training_paths_controller)
    command = clean_gets

    case command
    when "add"
      training_paths_controller.add
    when /\d+/
      training_paths_controller.view(command.to_i)
    else
      puts "I don't know the '#{command}' command."
    end
  end
end
