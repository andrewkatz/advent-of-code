# frozen_string_literal: true

horizontal_position = 0
depth = 0

File.readlines(File.join(File.dirname(__FILE__), 'input_2.txt')).each do |line|
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
