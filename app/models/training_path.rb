class TrainingPath

  attr_reader :errors

  def initialize(options)
    @name = options[:name]
  end

  def self.create(options)
    training_path = TrainingPath.new(options)
    training_path.save!
    training_path
  end

  def save!
    valid?
    # save to DB here
  end

  def valid?
    validate
    @errors.nil?
  end

  private

  def validate
    if @name.empty?
      @errors = "Name cannot be blank"
    elsif @name.length >= 30
      @errors = "name must be less than 30 characters"
    elsif @name.match(/^\d+$/)
      @errors = "Name must include letters"
    else
      @errors = nil
    end
  end
end
