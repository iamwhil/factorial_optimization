# Ugly first version. 
# This will all be refactored and split into classes in modules etc. 
# Just you wait n' see!

require 'csv'

class InputParameter

  attr_accessor :min, :max, :name

  def initialize(args)
    build_input_parameters(args)
  end

  def build_input_parameters(args)
    @min = args[:min].to_f
    @max = args[:max].to_f
    @name = args[:name]
  end

  def step_size(factor_space_width)
    (max - min) / factor_space_width.to_f
  end

  def mid_point
    (max - min) / 2.0
  end

  def info 
    puts self.name
    puts self.min
    puts self.max 
    puts self.step_size(20)
    puts self.mid_point
  end

end

def build_input_parameters(file_path='./inputs.csv')
  parameters = []
  get_input_parameters(file_path).each do |parameter_array|
    args = {factor_space_width: 20}
    args[:name], args[:min], args[:max] = parameter_array
    parameters << InputParameter.new(args)
  end
  parameters
end

def get_input_parameters(file_path)
  input_parameter_array = []
  CSV.foreach(file_path) do |row|
    input_parameter_array << row
  end
  input_parameter_array
end

input_parameters = build_input_parameters()


