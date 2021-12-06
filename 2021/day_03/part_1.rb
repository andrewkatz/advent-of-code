# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'awesome_print'

bits = {}

File.readlines(File.join(File.dirname(__FILE__), 'input_2.txt')).each do |line|
  line.chomp.chars.each_with_index do |bit, index|
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
