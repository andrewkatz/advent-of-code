# frozen_string_literal: true

require_relative '../advent'

unique_digit_sizes = [
  2, # 1
  4, # 4
  3, # 7
  7 # 8
]
unique_digits = 0

input('day_08').each do |entry|
  output = entry.split(' | ').last
  unique_digits += output.split.count do |value|
    unique_digit_sizes.include?(value.size)
  end
end

puts "There are #{unique_digits} instances of digits that use a unique number of segments"

# Input 1: 26
# Input 2: 303
# Input 3: 0
