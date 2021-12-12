# frozen_string_literal: true

require_relative '../advent'

score_lookup = {
  '(' => 1,
  '[' => 2,
  '{' => 3,
  '<' => 4
}
scores = []
open_characters = ['(', '[', '{', '<']
close_characters = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>'
}

input('day_10').each do |line|
  chunks = []
  corrupted = false

  line.chars.each do |character|
    if open_characters.include?(character)
      chunks << character
    elsif close_characters[chunks.last] == character
      chunks.pop
    else
      corrupted = true
      break
    end
  end

  next if corrupted

  scores << chunks.reverse.reduce(0) { |a, e| (a * 5) + score_lookup[e] }
end

winning_score = scores.sort[scores.size / 2]

puts "Winning score: #{winning_score}"

# Input 1: 288957
# Input 2: 2377613374
