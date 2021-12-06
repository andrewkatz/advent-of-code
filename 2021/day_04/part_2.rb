# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'awesome_print'

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

File.readlines(File.join(File.dirname(__FILE__), 'input_2.txt')).each_with_index do |line, index|
  if index.zero?
    drawn_numbers = line.chomp.split(',').map(&:to_i)
    next
  end

  board_rows << line.chomp.split.map(&:to_i) if row_index.nonzero?
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

  if boards.size > 1
    boards.reject!(&:win?)
    next
  else
    winning_board = boards.find(&:win?)
    next if winning_board.nil?
  end

  final_score = winning_board.score(number)
  puts "Final score: #{final_score}"
  break
end
