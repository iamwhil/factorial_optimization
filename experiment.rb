class Experiment
  require_relative 'experimental_matrix_builder.rb'

  attr_accessor :experimental_matrix, :results_matrix, :parameters, :factor_space_width, :name
  attr_reader :input_parameters_file

  def initialize(args={})
    @name = args['name'] ||= 'experiment'
    @input_parameters_file = args['input_parameters_file'] ||= './inputs.csv'
    @factor_space_width = args['factor_space_width'] ||= 20
    @experimental_matrix = build_experimental_matrix
  end

  def X 
    experimental_matrix
  end

  def Y
    results_matrix
  end

  def center_point_run
    # Center point run
  end

  def run(run_number)
    experimental_matrix.row(run_number)
  end

  def run_parameters(run_number)
    parameter_hash = {}
    coded_run = run(run_number)
    parameters.each_with_index do |parameter, index|
      run_value = parameters[index].mid_point + (coded_run[index] * parameters[index].step_size(factor_space_width))
      parameter_hash[parameter.name] = run_value
    end
    parameter_hash
  end

  def parameters
    @parameters ||= build_input_parameters
  end

  def describe_parameters
    parameters.each do |parameter|
      parameter.info
    end
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
    puts describe_parameters
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