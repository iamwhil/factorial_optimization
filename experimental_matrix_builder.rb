class ExperimentalMatrixBuilder
  require_relative './matrix.rb'

  attr_accessor :experimental_matrix
  attr_reader :parameters

  def initialize(parameters)
    @parameters = parameters
  end

  def call
    column_labels_to_indices = build_labels_to_indices
    column_indices_to_labels = build_indices_to_labels
    factor_matrix = build_factor_matrix(parameters.length)
    experimental_matrix = build_experimental_matrix(factor_matrix, column_labels_to_indices, column_indices_to_labels)
    Matrix.new(experimental_matrix, column_labels_to_indices, column_indices_to_labels)
  end

  private

    def permutations(array)
      @permutations ||= build_permutations(array)
    end

    def build_permutations(array)
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

    def shorthand_array
      parameters.inject([]) do |summ, parameter|
        summ << parameter.shorthand 
        summ
      end
    end

    def build_labels_to_indices
      i = 0
      permutations(shorthand_array).inject({}) do |summ, header|
        summ[header] = i
        i += 1
        summ
      end
    end

    def build_indices_to_labels
      i = 0
      permutations(shorthand_array).inject({}) do |summ, header|
        summ[i] = header
        i += 1
        summ
      end
    end

    def build_factor_matrix(parameter_count)
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

    def build_experimental_matrix(factor_matrix, column_labels_to_indices, column_indices_to_labels)
      initial_row_length = factor_matrix[0].length
      factor_matrix.each do |row|
        for i in initial_row_length..column_indices_to_labels.length-1
          columns_to_multiply = column_indices_to_labels[i].split(" ")
          test_value = columns_to_multiply.inject(1) do |summ, column_header|
            working_index = column_labels_to_indices[column_header]
            summ = summ * row[working_index]
            summ
          end
          row[i] = test_value
        end
      end
      factor_matrix
    end

end