class InputParameter

  attr_accessor :min, :max, :name, :shorthand

  def initialize(args)
    build_input_parameters(args)
  end

  def build_input_parameters(args)
    @min = args[:min].to_f
    @max = args[:max].to_f
    @name = args[:name]
    @shorthand = args[:shorthand]
  end

  def step_size(factor_space_width)
    (max - min) / factor_space_width.to_f
  end

  def mid_point
    (max - min) / 2.0
  end

  def info
    puts "\n"
    puts "#{self.name} | shorthand: #{self.shorthand}"
    puts "Min: #{self.min}"
    puts "Max: #{self.max}"
    puts "Step Size: #{self.step_size(20)}"
    puts "Mid Point: #{self.mid_point}"
  end

end