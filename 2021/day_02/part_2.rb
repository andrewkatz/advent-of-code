# frozen_string_literal: true

horizontal_position = 0
depth = 0
aim = 0

File.readlines(File.join(File.dirname(__FILE__), 'input_2.txt')).each do |line|
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
