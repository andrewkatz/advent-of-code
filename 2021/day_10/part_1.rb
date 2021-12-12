# frozen_string_literal: true

require_relative '../advent'

score_lookup = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25_137
}
score = 0
open_characters = ['(', '[', '{', '<']
close_characters = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>'
}

input('day_10').each do |line|
  chunks = []

  line.chars.each do |character|
    if open_characters.include?(character)
      chunks << character
    elsif close_characters[chunks.last] == character
      chunks.pop
    else
      puts "#{line} - Expected #{close_characters[chunks.last]}, but found #{character} instead"
      score += score_lookup[character]
      break
    end
  end
end

puts "Total syntax error score: #{score}"

# Input 1: 26397
# Input 2: 436497
