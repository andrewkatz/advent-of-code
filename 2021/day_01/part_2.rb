# frozen_string_literal: true

require_relative '../advent'

increased_count = 0
window = 0
measurements = {}

input('day_01').each do |line|
  windows = [window, window - 1, window - 2, window - 3].reject(&:negative?)

  windows.each do |w|
    measurements[w] ||= []
    measurements[w] << line.to_i

    if measurements[w].size == 3
      measurements[w] = measurements[w].sum
      increased_count += 1 if w.nonzero? && measurements[w] > measurements[w - 1]
    end
  end

  window += 1
end

puts "Increased #{increased_count} times"

# Input 1: 5
# Input 2: 1633
