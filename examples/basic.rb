#!/usr/bin/env ruby
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Palmshed
# frozen_string_literal: true

require_relative '../lib/nuntius'

# Load environment variables
Nuntius.load_env

# Basic text generation example
def basic_text_generation
  puts '=== Basic Text Generation ==='

  client = Nuntius::Client.new
  response = client.generate_text('Tell me a joke about programming')
  puts "Response: #{response}"
end

# Chat example
def chat_example
  puts "\n=== Chat Example ==="

  client = Nuntius::Client.new
  messages = [
    { role: 'user', content: 'Hello, what is Ruby?' },
    { role: 'model', content: 'Ruby is a dynamic programming language.' },
    { role: 'user', content: 'What makes it special?' }
  ]

  response = client.chat(messages)
  puts "Chat Response: #{response}"
end

# Different models example
def model_comparison
  puts "\n=== Model Comparison ==="

  # Flash model (default)
  flash_client = Nuntius::Client.new(model: :flash)
  flash_response = flash_client.generate_text('Explain AI in one sentence')
  puts "Flash Model: #{flash_response}"

  # Flash Lite model
  lite_client = Nuntius::Client.new(model: :flash_lite)
  lite_response = lite_client.generate_text('Explain AI in one sentence')
  puts "Flash Lite Model: #{lite_response}"
end

# Run examples
begin
  basic_text_generation
  chat_example
  model_comparison
rescue Nuntius::Error => e
  puts "Gemini AI Error: #{e.message}"
rescue StandardError => e
  puts "Unexpected Error: #{e.message}"
end
