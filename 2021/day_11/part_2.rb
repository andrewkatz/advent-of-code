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
@step = 0
@cache = {}

def step
  @step += 1
  @cache = {}

  puts "Step #{@step}"

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

def synchronized?
  @grid.all? { |_, energy_level| energy_level.zero? }
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

step until synchronized?

puts "First synchronized on step #{@step}"

# Input 1: 195
# Input 2: 517
