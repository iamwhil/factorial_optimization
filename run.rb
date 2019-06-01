# Ugly first version. 
# This will all be refactored and split into classes in modules etc. 
# Just you wait n' see!

require 'csv'
require_relative './matrix.rb'
require_relative './input_parameter.rb'
require_relative './experiment.rb'


# def build_input_parameters(file_path='./inputs.csv')
#   parameters = []
#   get_input_parameters(file_path).each do |parameter_array|
#     args = {factor_space_width: 20}
#     args[:name], args[:min], args[:max] = parameter_array
#     parameters << InputParameter.new(args)
#   end
#   parameters
# end

# def get_input_parameters(file_path)
#   input_parameter_array = []
#   CSV.foreach(file_path) do |row|
#     input_parameter_array << row
#   end
#   input_parameter_array
# end

# input_parameters = build_input_parameters()

# def permutations(array)
#   return_array = array.dup
#   while array.length > 0 
#     working_element = array.shift
#     return_array.each do |element|
#       if !element.include?(working_element)
#         return_array << ("#{element} #{working_element}").split(' ').sort.join(' ').to_s
#       end
#     end
#   end
#   return_array.uniq
# end

# array = ["A", "B"]

# column_labels = permutations(array.dup)

# i = 0
# column_headers = column_labels.inject({}) do |summ, header|
#   summ[header] = i
#   i += 1
#   summ
# end

# i = 0
# column_keys = column_labels.inject({}) do |summ, header|
#   summ[i] = header
#   i += 1
#   summ
# end


# def build_column(run, parameter_count)
#   toggle = 2**run / 2
#   count = 0
#   2**parameter_count.times do 
#     if count < toggle
#       matrix[j][run] = 1
#     else
#       matrix[j][run] = -1 
#     end
#     count += 1
#     if count >= toggle 
#       count = 0 
#     end
#   end
# end

# def build_factor_matrix(parameter_count)
#   matrix = []
#   for i in 0..2**parameter_count -1 
#     matrix << []
#   end
#   for i in 1..parameter_count
#     toggle = 2**i / 2
#     count = 0
#     for j in 0..2**parameter_count - 1
#       if count < toggle
#         matrix[j][i - 1] = 1
#       else
#         matrix[j][i - 1] = -1 
#       end
#       count += 1
#       if count >= toggle * 2
#         count = 0 
#       end
#     end
#   end
#   matrix
# end

# def build_experimental_matrix(matrix, column_headers, column_keys)
#   initial_row_length = matrix[0].length
#   matrix.each do |run|
#     for i in initial_row_length..column_keys.length-1
#       columns_to_multiply = column_keys[i].split(" ")
#       test_value = columns_to_multiply.inject(1) do |summ, column_header|
#         working_index = column_headers[column_header]
#         summ = summ * run[working_index]
#         summ
#       end
#       run[i] = test_value
#     end
#   end
#   matrix
# end

# factor_matrix = build_factor_matrix(array.length)
# experimental_matrix = build_experimental_matrix(factor_matrix, column_headers, column_keys)

# matrix = Matrix.new(experimental_matrix, column_headers, column_keys)

args = {}
args['factor_space_width'] = 20
args['name'] = "test_experiment"
experiment = Experiment.new(args)
puts experiment.run_parameters(1)