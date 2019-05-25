class Experiment

  attr_accessor :experimental_matrix, :results_matrix, :parameters, :factor_space_width
  attr_reader :input_parameters_file

  def initialize(args={})
    @input_parameters_file = args['input_parameters_file'] ||= './inputs.csv'
    @factor_space_width = args['factor_space_width'] ||= 20
    @experimental_matrix = args['experimental_matrix']
  end

  def X 
    experimental_matrix
  end

  def Y
    results_matrix
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
      # get array of column shorthand labels
      # get permutations
      # column labels => labels to indices
      # column keys => indices to label
      # build factor matrix
      # build experimental matrix
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