# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'awesome_print'

def input(day)
  input_file = ARGV.first || '1'

  File.readlines(File.join(File.dirname(__FILE__), day, "input_#{input_file}.txt")).each do |line|
    yield line.chomp
  end
end
