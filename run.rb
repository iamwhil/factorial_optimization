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

def permutations(array)
  return_array = array.dup
  while array.length > 0 
    working_element = array.shift
    return_array.each do |element|
      if !element.include?(working_element)
        return_array << (element + working_element).split('').sort.join.to_s
      end
    end
  end
  return_array.uniq
end


array = ["A", "B"]

perms = permutations(array.dup)
puts perms
puts perms.length

def build_column(run, parameter_count)
  toggle = 2**run / 2
  count = 0
  2**parameter_count.times do 
    if count < toggle
      matrix[j][run] = 1
    else
      matrix[j][run] = -1 
    end
    count += 1
    if count >= toggle 
      count = 0 
    end
  end
end

def build_matrix(parameter_count, keys)
  matrix = []
  for i in 0..2**parameter_count -1 
    matrix << []
  end
  for i in 1..parameter_count
    toggle = 2**i / 2
    count = 0
    for j in 0..2**parameter_count - 1
      if count < toggle
        matrix[j][i - 1] = 1
      else
        matrix[j][i - 1] = -1 
      end
      count += 1
      if count >= toggle * 2
        count = 0 
      end
    end
  end
  matrix
end

puts "ARRAY: #{array}"

# Matrix as array of arrays or 
# Matrix object with named cells (ij) ? 

matrix = build_matrix(array.length, perms)
puts matrix[0]