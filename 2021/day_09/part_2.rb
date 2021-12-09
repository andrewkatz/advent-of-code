# frozen_string_literal: true

require_relative '../advent'

@heightmap = []

input('day_09').each do |line|
  @heightmap << line.chars.map(&:to_i)
end

ALLOWED_BASIN_HEIGHT = 8
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

    low_points << [x, y]
  end
end

@adjacent_points_cache = {}

def find_higher_adjacent_points(basin, x, y)
  return if @adjacent_points_cache[basin].key?([x, y])

  height = height_at(x, y)

  [
    [x - 1, y],
    [x + 1, y],
    [x, y - 1],
    [x, y + 1]
  ].each do |adjacent_x, adjacent_y|
    adjacent_height = height_at(adjacent_x, adjacent_y)
    next if adjacent_height > ALLOWED_BASIN_HEIGHT
    next unless height < adjacent_height

    find_higher_adjacent_points(basin, adjacent_x, adjacent_y)
  end

  @adjacent_points_cache[basin][[x, y]] = true
end

basins = []

def print_basin(basin)
  @heightmap.size.times do |y|
    row = @heightmap[y]

    row.size.times do |x|
      height = height_at(x, y).to_s

      if @adjacent_points_cache.key?([basin, x, y])
        print height.blue
      else
        print height
      end
    end

    puts
  end

  puts
end

low_points.each_with_index do |point, basin|
  x, y = point
  @adjacent_points_cache[basin] = {}
  find_higher_adjacent_points(basin, x, y)
  basins << @adjacent_points_cache[basin].size
  # print_basin(basin)
end

largest_basins = basins.reject(&:zero?).sort.pop(3)
multiplied_size = largest_basins.reduce(1) { |a, e| a * e }

puts "3 largest basins: #{largest_basins.join(' * ')} = #{multiplied_size}"

# Input 1: 9 * 9 * 14 = 1134
# Input 2: 104 * 112 * 120 = 1397760
