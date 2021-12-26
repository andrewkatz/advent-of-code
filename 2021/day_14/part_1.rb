# frozen_string_literal: true

require_relative '../advent'

polymer = nil
insertion_pairs = {}

input('day_14').each_with_index do |line, index|
  polymer = line.chars if index.zero?
  next if index < 2

  pair, element = line.split(' -> ')
  insertion_pairs[pair] = element
end

steps = ARGV[1].to_i

puts "Template: #{polymer.join}"

steps.times do |step|
  insertions = []

  polymer.each_with_index do |element, index|
    next if index.zero?

    pair = polymer[index - 1] + element
    insertions << insertion_pairs[pair]
  end

  polymer = polymer.zip(insertions).flatten.compact

  puts "After step #{step + 1}: #{polymer.join}"
end

counts = {}
polymer.each do |element|
  counts[element] ||= 0
  counts[element] += 1
end

least_common, most_common = counts.minmax_by { |_, v| v }

puts "Least common element: #{least_common.first} (#{least_common.last})"
puts "Most common element:  #{most_common.first} (#{most_common.last})"

result = most_common.last - least_common.last
puts "Result: #{result}"

# Input 1: 1588
# Input 2: 3555
