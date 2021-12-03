# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'awesome_print'

diagnostic_report = []

File.readlines(File.join(File.dirname(__FILE__), 'input_2.txt')).each do |line|
  diagnostic_report << line.chomp
end

def find_value(report, most_common: true)
  report_copy = report.dup
  bit_index = 0
  bit_counts = nil

  while report_copy.size > 1
    bit_counts = {}

    report_copy.each do |number|
      bit = number[bit_index]
      bit_counts[bit] ||= 0
      bit_counts[bit] += 1
    end

    sorted_bit_counts = bit_counts.to_a.sort_by(&:last)
    equal_counts = sorted_bit_counts.map(&:last).uniq.size == 1

    bit_filter = if equal_counts
                   most_common ? '1' : '0'
                 else
                   sorted_bits = sorted_bit_counts.map(&:first)
                   most_common ? sorted_bits.last : sorted_bits.first
                 end

    report_copy.select! { |number| number[bit_index] == bit_filter }
    bit_index += 1
  end

  report_copy.first.to_i(2)
end

oxygen_generator_rating = find_value(diagnostic_report, most_common: true)
co2_scrubber_rating = find_value(diagnostic_report, most_common: false)
life_support_rating = oxygen_generator_rating * co2_scrubber_rating

puts "Life support rating: #{life_support_rating}"
