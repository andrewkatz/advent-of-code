# frozen_string_literal: true

require_relative '../advent'

@grid = {}
@size_x = 0
@size_y = 0

input('day_11').each_with_index do |line, y|
  @size_y += 1
  @size_x = line.size

  line.chars.each_with_index do |energy_level, x|
    @grid[[x, y]] = energy_level.to_i
  end
end

MAX_ENERGY = 10
@flashes = 0
@cache = {}

def step
  @cache = {}

  @size_x.times do |x|
    @size_y.times do |y|
      @grid[[x, y]] += 1
    end
  end

  @size_x.times do |x|
    @size_y.times do |y|
      flash?(x, y)
    end
  end

  @grid.each do |position, energy_level|
    @grid[position] = 0 if energy_level >= MAX_ENERGY
  end

  print_grid
end

def flash?(x, y)
  return if @grid[[x, y]].nil?
  return if @grid[[x, y]] < MAX_ENERGY
  return if @cache.key?([x, y])

  @flashes += 1
  @cache[[x, y]] = true

  [
    [x - 1, y],
    [x - 1, y - 1],
    [x - 1, y + 1],
    [x + 1, y],
    [x + 1, y - 1],
    [x + 1, y + 1],
    [x, y - 1],
    [x, y + 1]
  ].each do |adjacent_x, adjacent_y|
    @grid[[adjacent_x, adjacent_y]] += 1 if @grid.key?([adjacent_x, adjacent_y])
    flash?(adjacent_x, adjacent_y)
  end
end

def print_grid
  @size_y.times do |y|
    @size_x.times do |x|
      energy_level = @grid[[x, y]]
      print(energy_level.zero? ? energy_level.to_s.blue : energy_level)
    end

    puts
  end

  puts
end

print_grid

step_count = (ARGV[1] || '100').to_i
step_count.times do |i|
  puts "Step #{i + 1}"
  step
end

puts "Flashes after #{step_count} steps: #{@flashes}"

# Input 1: 1656
# Input 2: 1588
