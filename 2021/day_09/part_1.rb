# frozen_string_literal: true

require_relative '../advent'

@heightmap = []

input('day_09').each do |line|
  @heightmap << line.chars.map(&:to_i)
end

INVALID_LOCATION = 10

def height_at(x, y)
  return INVALID_LOCATION if x.negative? || y.negative?
  return INVALID_LOCATION unless y < @heightmap.size
  return INVALID_LOCATION unless x < @heightmap.first.size

  @heightmap[y][x]
end

low_points = []

@heightmap.size.times do |y|
  row = @heightmap[y]

  row.size.times do |x|
    height = height_at(x, y)

    next unless height < height_at(x - 1, y)
    next unless height < height_at(x + 1, y)
    next unless height < height_at(x, y - 1)
    next unless height < height_at(x, y + 1)

    low_points << height
  end
end

risk = low_points.reduce(0) { |a, e| a + e + 1 }

puts "There are #{low_points.size} low points, with a risk of #{risk}"

# Input 1: 4, 15
# Input 2: 207, 462
