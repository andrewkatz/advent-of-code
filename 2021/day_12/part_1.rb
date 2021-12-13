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

def find_path(cave, current_path)
  if cave == 'end'
    @paths << (current_path + [cave])
    return
  end

  return if cave == cave.downcase && current_path.include?(cave)

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

# Input 1: 10
# Input 2: 19
# Input 3: 226
# Input 4: 4338
