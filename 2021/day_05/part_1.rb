# frozen_string_literal: true

require_relative '../advent'

class Point
  attr_reader :x, :y

  def initialize(x_y)
    @x, @y = x_y.split(',').map(&:to_i)
  end
end

lines = []

input('day_05').each do |line|
  start, stop = line.chomp.split(' -> ')
  start = Point.new(start)
  stop = Point.new(stop)

  lines << [start, stop] if start.x == stop.x || start.y == stop.y
end

grid = {}

lines.each do |start, stop|
  x_range = start.x > stop.x ? start.x.downto(stop.x) : start.x.upto(stop.x)
  y_range = start.y > stop.y ? start.y.downto(stop.y) : start.y.upto(stop.y)

  x_range.each do |x|
    y_range.each do |y|
      grid[y] ||= {}
      grid[y][x] ||= 0
      grid[y][x] += 1
    end
  end
end

dangerous_points = 0

grid.each do |_, row|
  row.each do |_, line_count|
    dangerous_points += 1 if line_count > 1
  end
end

puts "Dangerous points: #{dangerous_points}"

# Input 1: 5
# Input 2: 7142
