#!/usr/bin/env ruby
# frozen_string_literal: true
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Palmshed

require_relative '../lib/nuntius'

puts 'Nuntius status'
puts '=' * 50

# Load environment
Nuntius.load_env

puts 'Environment loaded'
puts 'Client available'

puts "\nSupported Models:"
Nuntius::Client::MODELS.each do |key, model_id|
  puts "  #{key.to_s.ljust(12)} -> #{model_id}"
end

puts "\nModel defaults:"
puts '  app    -> gemini-3.7-flash (default, Flash family)'
puts '  fallback -> gemini-3.6-flash'
puts '  :flash -> gemini-3.7-flash'
puts '  :flash_fallback -> gemini-3.6-flash'
puts '  :flash_lite -> gemini-3.1-flash-lite (lightweight)'

puts "\nUsage Examples:"
puts <<~RUBY
  # Ruby client model aliases: Flash family only (Free-Tier)
  client = Nuntius::Client.new(model: :flash)          # gemini-3.7-flash (default)
  client = Nuntius::Client.new(model: :flash_fallback) # gemini-3.6-flash
  client = Nuntius::Client.new(model: :flash_lite)     # gemini-3.1-flash-lite

  # Specific versions
  client = Nuntius::Client.new(model: :flash_3_7)  # gemini-3.7-flash
  client = Nuntius::Client.new(model: :flash_3_6)  # gemini-3.6-flash
RUBY

puts "\nAvailable Scripts:"
puts '  ruby scripts/modelchecker.rb     - Check model availability'
puts '  ruby examples/modelsdemo.rb      - Demo all models'
puts '  ruby test/runner.rb              - Run Ruby tests'

puts "\nReady."
puts '=' * 50
