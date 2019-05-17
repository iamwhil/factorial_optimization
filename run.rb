require 'csv'

def get_input_parameters(file_path='./inputs.csv')
  CSV.foreach(file_path) do |row|
    puts row
  end
end

get_input_parameters()

