# frozen_string_literal: true

require_relative '../advent'

@school = input('day_06').first.split(',').map(&:to_i).map { |f| f - 8 }
@days = (ARGV[1] || 18).to_i
@total_fish = @school.size

@cache = {}

def spawn(day_created)
  return 0 if (day_created + 8) >= @days
  return @cache[day_created] unless @cache[day_created].nil?

  new_fish = ((@days - day_created - 2) / 7.0).floor

  @cache[day_created] = new_fish + new_fish.times.to_a.map do |n|
    spawn(day_created + 2 + (7 * (n + 1)))
  end.sum
end

@school.each do |fish|
  @total_fish += spawn(fish)
end

puts "After #{@days} days, there are a total of #{@total_fish} fish."
