# frozen_string_literal: true

require_relative '../advent'

output_value_sum = 0

digit_size_map = {
  2 => 1,
  4 => 4,
  3 => 7,
  7 => 8
}

def add_digit(map, digit, value)
  map[digit.chars.sort.join] = value
end

input('day_08').each do |entry|
  input, output = entry.split(' | ').map(&:split)

  map = {}
  input.each do |digit|
    unique_size_digit = digit_size_map[digit.size]
    add_digit(map, digit, unique_size_digit) unless unique_size_digit.nil?
  end

  one = map.key(1)

  six = input.find do |d|
    d.size == 6 && (one.chars - d.chars).size == 1
  end
  add_digit(map, six, 6)
  top_right = (one.chars - six.chars).first

  three = input.find { |d| d.size == 5 && (one.chars - d.chars).size.zero? }
  add_digit(map, three, 3)

  two = input.find { |d| d.size == 5 && d != three && d.chars.include?(top_right) }
  add_digit(map, two, 2)

  five = input.find { |d| d.size == 5 && d != two && d != three }
  add_digit(map, five, 5)

  bottom_left = (six.chars - five.chars).first
  zero = input.find { |d| d.size == 6 && d != six && d.chars.include?(bottom_left) }
  add_digit(map, zero, 0)

  nine = input.find { |d| d.size == 6 && d != six && d != zero }
  add_digit(map, nine, 9)

  decoded_output = output.map do |v|
    map[v.chars.sort.join]
  end

  output_value_sum += decoded_output.join.to_i
end

puts "Output value sum: #{output_value_sum}"

# Input 1: 61229
# Input 2: 961734
# Input 3: 5353
