# frozen_string_literal: true

require_relative '../advent'

horizontal_position = 0
depth = 0

input('day_02').each do |line|
  command, units = line.chomp.split
  units = units.to_i

  case command
  when 'forward'
    horizontal_position += units
  when 'down'
    depth += units
  when 'up'
    depth -= units
  end
end

puts "Final position is #{horizontal_position} * #{depth} = #{horizontal_position * depth}"

# Input 1: 150
# Input 2: 1989014
