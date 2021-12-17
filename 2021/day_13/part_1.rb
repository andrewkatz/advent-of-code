# frozen_string_literal: true

require_relative '../advent'

dots = []
folds = []

input('day_13').each do |line|
  case line
  when /^\d+,\d+/
    match_data = line.match(/^(\d+),(\d+)/)
    x = match_data[1].to_i
    y = match_data[2].to_i
    dots << [x, y]
  when /fold along (x|y)=(\d+)/
    match_data = line.match(/fold along (x|y)=(\d+)/)
    axis = match_data[1]
    value = match_data[2].to_i
    folds << [axis, value]
  end
end

folds.each do |axis, value|
  dots.each_with_index do |dot, index|
    x, y = dot

    if axis == 'x'
      if x == value
        dots[index] = nil
      elsif x > value
        dots[index] = [value - (x - value), y]
      end
    elsif y == value
      dots[index] = nil
    elsif y > value
      dots[index] = [x, value - (y - value)]
    end
  end

  dots.compact!
  dots.uniq!

  puts "#{dots.size} visible after fold"
end

# Input 1: 17
# Input 2: 751
