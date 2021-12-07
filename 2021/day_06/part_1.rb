# frozen_string_literal: true

require_relative '../advent'

school = input('day_06').first.split(',').map(&:to_i)

days = ARGV[1] || 18
days.to_i.times do |_day|
  school.size.times do |index|
    if school[index].zero?
      school << 8
      school[index] = 6
    else
      school[index] -= 1
    end
  end
end

puts "After #{days} days, there are a total of #{school.size} fish."
