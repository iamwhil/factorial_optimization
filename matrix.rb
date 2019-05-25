class Matrix

  attr_accessor :matrix, :column_labels_to_indices, :column_indices_to_labels

  def initialize(matrix, column_labels_to_indices, column_indices_to_labels)
    @matrix = matrix
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

  def describe
    matrix.each do |row|
      puts row.join(" | ")
    end
  end

end