class MatrixError < StandardError; end

class Matrix

  attr_accessor :matrix, :column_labels_to_indices, :column_indices_to_labels

  def initialize(matrix, column_labels_to_indices, column_indices_to_labels)
    @matrix = matrix
    # Check that the matrix is 2 dimensional.
    @column_labels_to_indices = column_labels_to_indices
    @column_indices_to_labels = column_indices_to_labels
  end

  def column_labels
    puts "Column Labels: #{column_labels_to_indices.keys.join(" | ")}"
  end

  def cell(i,j)
    puts "Value at #{i}, #{j}: #{matrix[i][j]}"
    matrix[i][j]
  end

  def row(i)
    puts "Row #{i}: #{matrix[i].join(" | ")}"
    matrix[i]
  end

  def column(i)
    column = matrix.map { |row| row[i] }
    pretty_column = column.map {|row| "| #{row} |"}.join("\n")
    puts puts "Column #{i}:\n #{pretty_column}"
    column
  end

  def describe
    matrix.each do |row|
      puts row.map{ |element| element.to_s.rjust(2,' ') }.join(" | ")
    end
  end

  def length
    matrix.length
  end

  def size 
    [matrix.length, matrix[0].length]
  end

  def *(matrix2)
    matrix1 = self
    matrix2 = matrix2
    # Check compatibile
    if matrix1.size[1] != matrix2.size[0]
      raise MatrixError.new("Unable to multiply matrices: Matrix 1 - #{matrix1.size.inspect} * Matrix 2 - #{matrix2.size.inspect}.  Inner elements must be the same.")
    end
    solutions_array = []
    matrix1.size[1].times do 
      solution_arrays << Array.new(matrix1.size[1])
    end
    puts solutions_array.inspect
  end

end