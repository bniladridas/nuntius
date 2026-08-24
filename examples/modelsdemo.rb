# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Palmshed

#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/nuntius'

# Load environment variables
Nuntius.load_env

puts 'Models demo'
puts '=' * 50

# Check if API key is available
unless ENV['GEMINI_API_KEY']
  puts 'ERROR: Please set GEMINI_API_KEY environment variable'
  exit 1
end

# Demo prompt
prompt = 'Explain what makes you special in exactly one sentence.'

# Test different models - Flash family only (Free-Tier)
models_to_demo = [
  { key: :flash, name: 'Flash', description: 'Default model (gemini-3.7-flash)' },
  { key: :flash_3_6, name: 'Flash 3.6', description: 'Fallback model (gemini-3.6-flash)' },
  { key: :flash_3_7, name: 'Gemini 3.7 Flash', description: 'Current default' },
  { key: :flash_3_1_lite, name: 'Gemini 3.1 Flash Lite', description: 'Lightweight text model' },
  { key: :flash_2_0, name: 'Gemini 2.0 Flash', description: 'Pinned 2.0 model' }
]

models_to_demo.each do |model_info|
  puts "\nTesting #{model_info[:name]}"
  puts "   #{model_info[:description]}"
  puts "   Model ID: #{Nuntius::Client::MODELS[model_info[:key]]}"
  puts '-' * 40

  begin
    client = Nuntius::Client.new(model: model_info[:key])

    # Measure response time
    start_time = Time.now
    response = client.generate_text(prompt)
    end_time = Time.now

    response_time = ((end_time - start_time) * 1000).round(2)

    puts "[SUCCESS] Response (#{response_time}ms): #{response.strip}"
  rescue Nuntius::Error => e
    if e.message.include?('quota')
      puts '[WARNING] Quota exceeded - this is normal for free tier'
    else
      puts "[ERROR] Error: #{e.message}"
    end
  rescue StandardError => e
    puts "[ERROR] Unexpected error: #{e.message}"
  end

  # Small delay to avoid rate limiting
  sleep(1)
end

puts "\n#{'=' * 50}"
puts 'Model Selection Guide:'
puts '* Use :flash for the default Flash alias (gemini-3.7-flash)'
puts '* Use :flash_3_6 for fallback (gemini-3.6-flash)'
puts '* Use :flash_3_1_lite for lighter requests'
puts '* Use :flash_2_0 when that exact model is required'

puts "\nAvailable model keys:"
Nuntius::Client::MODELS.each do |key, model_id|
  puts "  #{key}: #{model_id}"
end

puts "\nUsage example:"
puts <<~RUBY
  # Use the default model (Flash 3.7)
  client = Nuntius::Client.new(model: :flash)

  # Use the fallback model
  client = Nuntius::Client.new(model: :flash_3_6)

  # Use a specific version
  client = Nuntius::Client.new(model: :flash_2_0)
RUBY
