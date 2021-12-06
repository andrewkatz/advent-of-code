# frozen_string_literal: true

require_relative '../advent'

class Number
  attr_reader :value

  def initialize(value)
    @value = value
    @marked = false
  end

  def marked?
    @marked
  end

  def mark
    @marked = true
  end
end

class Board
  def initialize(rows)
    @rows = rows.map do |row|
      row.map do |number|
        Number.new(number)
      end
    end
  end

  def mark(number_to_mark)
    @rows.each do |row|
      row.each do |number|
        number.mark if number.value == number_to_mark
      end
    end
  end

  def win?
    winning_row? || winning_column?
  end

  def score(final_number)
    unmarked_sum = 0

    @rows.each do |row|
      row.each do |number|
        unmarked_sum += number.value unless number.marked?
      end
    end

    unmarked_sum * final_number
  end

  private

  def winning_row?
    @rows.any? { |row| row.all?(&:marked?) }
  end

  def winning_column?
    (0..4).to_a.any? do |column|
      @rows.map { |row| row[column] }.all?(&:marked?)
    end
  end
end

drawn_numbers = nil

boards = []
board_rows = []
row_index = 0

input('day_04').each_with_index do |line, index|
  if index.zero?
    drawn_numbers = line.split(',').map(&:to_i)
    next
  end

  board_rows << line.split.map(&:to_i) if row_index.nonzero?
  row_index += 1
  next if row_index < 6

  boards << Board.new(board_rows)
  board_rows = []
  row_index = 0
end

drawn_numbers.each do |number|
  boards.each do |board|
    board.mark(number)
  end

  winning_board = boards.find(&:win?)
  next if winning_board.nil?

  final_score = winning_board.score(number)
  puts "Final score: #{final_score}"
  break
end

# Input 1: 4512
# Input 2: 60368
