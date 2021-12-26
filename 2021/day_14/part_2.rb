# frozen_string_literal: true

require_relative '../advent'

polymer_template = nil
@insertion_pairs = {}

puts 'Reading input'
input('day_14').each_with_index do |line, index|
  polymer_template = line.chars if index.zero?
  next if index < 2

  pair, element = line.split(' -> ')
  @insertion_pairs[pair] = element
end

@counts = Hash.new(0)
@max_steps = ARGV[1].to_i
@half_max_steps = @max_steps / 2
@cache = {}

def count_element(element)
  @counts[element] += 1
end

def count_polymer(polymer, step)
  puts "step:#{step} polymer:#{polymer}"
  inserted_elements = Hash.new(0)

  return inserted_elements if step > @max_steps

  polymer.each_with_index do |element, index|
    next if index.zero?

    previous_element = polymer[index - 1]
    pair = previous_element + element

    cache_step = step > @half_max_steps ? @max_steps - step : step
    cached_inserted_pairs = @cache[[pair, cache_step]]
    puts "searching cache for: #{[pair, cache_step]}"

    unless cached_inserted_pairs.nil?
      cached_inserted_pairs.each do |inserted_element, count|
        inserted_elements[inserted_element] += count
      end
      next
    end

    inserted_element = @insertion_pairs[pair]
    inserted_elements[inserted_element] += 1

    updated_polymer = [previous_element, inserted_element, element]
    down_inserted_elements = count_polymer(updated_polymer, step + 1)
    down_inserted_elements.each do |down_inserted_element, count|
      inserted_elements[down_inserted_element] += count
    end

    down_inserted_elements[inserted_element] += 1
    @cache[[pair, step]] = down_inserted_elements
  end

  ap inserted_elements

  inserted_elements
end

polymer_template.each do |element|
  count_element(element)
end

count_polymer(polymer_template, 1).each do |element, count|
  @counts[element] += count
end

least_common, most_common = @counts.minmax_by { |_, v| v }

puts "Least common element: #{least_common.first} (#{least_common.last})"
puts "Most common element:  #{most_common.first} (#{most_common.last})"

result = most_common.last - least_common.last
puts "Result: #{result}"
