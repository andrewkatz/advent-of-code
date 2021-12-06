# frozen_string_literal: true

require_relative '../advent'

report = []
increased_count = 0

input('day_01').each_with_index do |line, index|
  value = line.to_i
  report[index] = value

  next if index.zero?

  increased_count += 1 if value > report[index - 1]
end

puts "Increased #{increased_count} times"

# Input 1: 7
# Input 2: 1602
