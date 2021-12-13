# frozen_string_literal: true

require_relative '../advent'

@map = {}

input('day_12').each do |line|
  a, b = line.split('-')

  @map[a] ||= []
  @map[a] << b

  @map[b] ||= []
  @map[b] << a
end

@paths = []

def visited_small_cave_twice?(path)
  small_caves = path.select { |c| c.size < 3 && c == c.downcase }
  small_caves.size != small_caves.uniq.size
end

def skip_cave?(cave, current_path)
  return true if cave == 'start'

  cave == cave.downcase && visited_small_cave_twice?(current_path) && current_path.include?(cave)
end

def find_path(cave, current_path)
  if cave == 'end'
    @paths << (current_path + [cave])
    return
  end

  return if skip_cave?(cave, current_path)

  Array(@map[cave]).each do |adjacent_cave|
    find_path(adjacent_cave, current_path + [cave])
  end
end

@map['start'].each do |cave|
  find_path(cave, ['start'])
end

@paths.map { |path| path.join(',') }.sort.each do |path|
  puts path
end

puts "Found #{@paths.size} paths"

# Input 1: 36
# Input 2: 103
# Input 3: 3509
# Input 4: 114189
