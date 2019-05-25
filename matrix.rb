class Matrix

  attr_accessor :matrix, :column_labels_to_indices

  def initialize(matrix, column_labels, column_labels_to_indices)
    @matrix = matrix
    @column_labels = column_labels
    @column_labels_to_indices = column_labels_to_indices
  end

  def column_labels
    puts "Column Labels: #{@column_labels.keys.join(" | ")}"
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