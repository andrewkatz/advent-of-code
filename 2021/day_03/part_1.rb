# frozen_string_literal: true

require_relative '../advent'

bits = {}

input('day_03').each do |line|
  line.chars.each_with_index do |bit, index|
    bits[index] ||= {}
    bits[index][bit] ||= 0
    bits[index][bit] += 1
  end
end

gamma_rate = []
epsilon_rate = []

bits.each do |_, bit_counts|
  epsilon_bit, gamma_bit = bit_counts.to_a.sort_by(&:last).map(&:first)
  epsilon_rate << epsilon_bit
  gamma_rate << gamma_bit
end

gamma_rate = gamma_rate.join.to_i(2)
epsilon_rate = epsilon_rate.join.to_i(2)

power_consumption = gamma_rate * epsilon_rate

puts "Power consumption: #{power_consumption}"

# Input 1: 198
# Input 2: 852500
