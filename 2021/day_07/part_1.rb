# frozen_string_literal: true

require_relative '../advent'

horizontal_positions = input('day_07').first.split(',').map(&:to_i)
cheapest_position = nil
cheapest_fuel_cost = nil

horizontal_positions.uniq.each do |possible_position|
  fuel_cost = horizontal_positions.map { |p| (p - possible_position).abs }.sum

  if cheapest_fuel_cost.nil? || fuel_cost < cheapest_fuel_cost
    cheapest_position = possible_position
    cheapest_fuel_cost = fuel_cost
  end
end

puts "Cheapest position is #{cheapest_position}, costing #{cheapest_fuel_cost} fuel"

# Input 1: 37 fuel
# Input 2: 352707 fuel
