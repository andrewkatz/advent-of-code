# frozen_string_literal: true

require_relative '../advent'

horizontal_position = 0
depth = 0
aim = 0

input('day_02').each do |line|
  command, units = line.chomp.split
  units = units.to_i

  case command
  when 'forward'
    horizontal_position += units
    depth += units * aim
  when 'down'
    aim += units
  when 'up'
    aim -= units
  end
end

puts "Final position is #{horizontal_position} * #{depth} = #{horizontal_position * depth}"

# Input 1: 900
# Input 2: 2006917119
