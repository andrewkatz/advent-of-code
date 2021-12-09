# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'awesome_print'
require 'colorize'

def input(day)
  input_file = ARGV.first || '1'

  Enumerator.new do |lines|
    File.readlines(File.join(File.dirname(__FILE__), day, "input_#{input_file}.txt")).each do |line|
      lines << line.chomp
    end
  end
end
