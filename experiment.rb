class Experiment
  require_relative 'experimental_matrix_builder.rb'

  attr_accessor :experimental_matrix, :results_matrix, :parameters, :factor_space_width, :name
  attr_reader :input_parameters_file

  def initialize(args={})
    @name = args['name'] ||= 'example'
    @input_parameters_file = args['input_parameters_file'] ||= './inputs.csv'
    @factor_space_width = args['factor_space_width'] ||= 20
    @experimental_matrix = build_experimental_matrix
    @results_matrix = build_results_matrix
  end

  def X 
    experimental_matrix
  end

  def Y
    results_matrix
  end

  def center_point_run
    raise NotImplementedError.new("Whil needs to build this.")
    # Center point run
  end

  def parameters
    @parameters ||= build_input_parameters
  end

  def describe_parameters
    parameters.each do |parameter|
      parameter.info
    end
  end

  def run_parameters(run_number)
    parameter_hash = {}
    coded_run = experimental_matrix.row(run_number)
    parameters.each_with_index do |parameter, index|
      run_value = parameters[index].mid_point + (coded_run[index] * parameters[index].step_size(factor_space_width))
      parameter_hash[parameter.name] = run_value
    end
    parameter_hash
  end

  def describe_parameter(name)
    parameters.each do |parameter|
      if parameter.name.chomp == name.chomp
        parameter.info
        return nil
      end
    end
    puts "Unable to find parameter with name: #{name}"
  end

  def shorthand_parameters
    parameters.inject([]) do |summ, parameter|
      summ << parameter.shorthand
      summ
    end
  end

  def describe
    puts "_________________"
    puts "\nExperiment: #{name}\n"
    puts "Full factorial 2^#{parameters.length} experiment - #{2**parameters.length} runs\n"
    describe_parameters
    experimental_matrix.column_labels
    experimental_matrix.describe
    puts "_________________"
  end

  private

    def build_input_parameters
      shorthand = "A"
      get_input_parameters.inject([]) do |summ, parameter_array|
        args = {factor_space_width: factor_space_width, shorthand: shorthand}
        shorthand = shorthand.next
        args[:name], args[:min], args[:max] = parameter_array
        summ << InputParameter.new(args)
        summ
      end
    end

    def get_input_parameters
      input_parameter_array = []
      CSV.foreach(input_parameters_file) do |row|
        input_parameter_array << row
      end
      input_parameter_array
    end

    def build_experimental_matrix
      ::ExperimentalMatrixBuilder.new(parameters).call
    end

    def build_results_matrix
      initial_matrix = Array.new(experimental_matrix.length)
      saved_experimental_results.each_with_index do |value, index|
        initial_matrix[index] = value
      end
      # Need to turn this into an rows x columns matrix nxm 8x1
      initial_matrix
    end

    def saved_experimental_results
      saved_data_file = "./data/#{self.name}_results.csv"
      CSV.read(saved_data_file).first
    end

    def shorthand_permutations(array)
      return_array = array.dup
      while array.length > 0 
        working_element = array.shift
        return_array.each do |element|
          if !element.include?(working_element)
            return_array << ("#{element} #{working_element}").split(' ').sort.join(' ').to_s
          end
        end
      end
      return_array.uniq
    end

end