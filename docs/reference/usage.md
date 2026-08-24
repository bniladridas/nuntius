# Usage

<br>

# Getting Started

<br>

# 1. Installation

<br>

```bash
gem install nuntius-rb
```

<br>

# 2. Get API Key

<br>

1. Visit [Google AI Studio](https://aistudio.google.com/app/apikey)
2. Create a new API key
3. Set it as environment variable or in .env file

<br>

# 3. Basic Setup

<br>

Create a `.env` file:
```
GEMINI_API_KEY=your_api_key_here
```

<br>

# Basic Usage

<br>

# Simple Text Generation

<br>

```ruby
require 'nuntius'

# Load environment variables
Nuntius.load_env

# Create client and generate text
client = Nuntius::Client.new
response = client.generate_text("Write a haiku about programming")
puts response
```

<br>

# Chat Conversations

<br>

```ruby
client = Nuntius::Client.new
messages = [
  { role: 'user', content: 'Hello, what is Ruby?' },
  { role: 'model', content: 'Ruby is a programming language.' },
  { role: 'user', content: 'What makes it special?' }
]

response = client.chat(messages)
puts response
```

<br>

# Advanced Usage

<br>

# Custom Parameters

<br>

```ruby
# Creative writing (high temperature)
creative_response = client.generate_text(
  "Write a story about a robot",
  temperature: 0.9,      # More creative
  max_tokens: 200,       # Longer response
  top_p: 0.95,          # More diverse
  top_k: 50             # Consider more options
)

# Factual responses (low temperature)
factual_response = client.generate_text(
  "Explain quantum computing",
  temperature: 0.1,      # More deterministic
  max_tokens: 100,       # Shorter response
  top_p: 0.8,           # Less diverse
  top_k: 20             # Consider fewer options
)
```

<br>

# Different Models

<br>

```ruby
# Default model (Flash 3.7)
default_client = Nuntius::Client.new

# Fallback model
fallback_client = Nuntius::Client.new(model: :flash_3_6)

# Flash Lite model (faster, lighter)
lite_client = Nuntius::Client.new(model: :flash_lite)

# Compare responses
default_response = default_client.generate_text("Explain AI")
fallback_response = fallback_client.generate_text("Explain AI")
lite_response = lite_client.generate_text("Explain AI")
```

<br>

# Error Handling

<br>

```ruby
begin
  client = Nuntius::Client.new
  response = client.generate_text("Your prompt")
  puts response
rescue Nuntius::AuthenticationError => e
  puts "API key error: #{e.message}"
rescue Nuntius::APIError => e
  puts "API error: #{e.message}"
rescue Nuntius::NetworkError => e
  puts "Network error: #{e.message}"
rescue Nuntius::Error => e
  puts "General error: #{e.message}"
end
```

<br>

# Batch Processing

<br>

```ruby
client = Nuntius::Client.new
prompts = [
  "Write a haiku about coding",
  "Explain recursion briefly",
  "Compare Ruby and Python."
]

prompts.each_with_index do |prompt, index|
  begin
    response = client.generate_text(prompt)
    puts "#{index + 1}. #{prompt}"
    puts "   Response: #{response}\n\n"
  rescue => e
    puts "#{index + 1}. Error: #{e.message}\n\n"
  end
end
```

<br>

# CLI Usage

<br>

# Test Connection

<br>

```bash
./bin/gemini test
```

<br>

# Generate Text

<br>

```bash
./bin/gemini generate "Write a joke about programming"
```

<br>

# Interactive Chat

<br>

```bash
./bin/gemini chat
```

<br>

This starts an interactive session where you can have a conversation with the AI.

<br>

# Help

<br>

```bash
./bin/gemini help
```

<br>

# Configuration Options

<br>

# Environment Variables

<br>

- `GEMINI_API_KEY`: Your API key (required)
- `RAILS_ENV` / `RACK_ENV`: Environment detection for logging levels

<br>

# Logging Levels

<br>

- **Production**: ERROR only
- **Test**: WARN and above
- **Development**: DEBUG (all messages)

<br>

# Model Options

<br>

| Model | Speed | Quality | Use Case |
|-------|-------|---------|----------|
| `:flash` | Fast | Good | Default (3.7) |
| `:flash_3_6` | Fast | Good | Fallback |
| `:flash_lite` | Fast | Good | Quick responses |

<br>

# Best Practices

<br>

# 1. API Key Security

<br>

```ruby
# Good - Use environment variables
client = Nuntius::Client.new

# Bad - Hardcode API key
client = Nuntius::Client.new('AIza...')
```

<br>

# 2. Error Handling

<br>

```ruby
# Good - Handle specific errors
begin
  response = client.generate_text(prompt)
rescue Nuntius::AuthenticationError
  # Handle auth error
rescue Nuntius::APIError
  # Handle API error
end

# Bad - Catch all errors
begin
  response = client.generate_text(prompt)
rescue => e
  # Too broad
end
```

<br>

# 3. Parameter Tuning

<br>

```ruby
# For creative tasks
temperature: 0.7-0.9
top_p: 0.9-0.95
top_k: 40-50

# For factual tasks
temperature: 0.1-0.3
top_p: 0.8-0.9
top_k: 20-30
```

<br>

# 4. Prompt Engineering

<br>

```ruby
# Good - Clear, specific prompts
"Write a haiku about Ruby programming with 5-7-5 syllable structure"

# Bad - Vague prompts
"Write something about Ruby"
```

<br>

# Troubleshooting

<br>

# Common Issues

<br>

1. **"API key is required"**
   - Set `GEMINI_API_KEY` environment variable
   - Check .env file is loaded with `Nuntius.load_env`

<br>

2. **"Invalid API key format"**
   - Ensure API key starts with "AIza"
   - Check for extra spaces or characters

<br>

3. **"Prompt cannot be empty"**
   - Provide non-empty string to `generate_text`

<br>

4. **Network timeouts**
   - Check internet connection
   - API has 30-second timeout built-in

<br>

# Debug Logging

<br>

Enable debug logging to see request and response details:

<br>

```ruby
Nuntius::Utils::Logger.instance.level = Logger::DEBUG
```

<br>

# Request Tips

<br>

1. **Use Flash Lite for lower latency** when the task is small
2. **Adjust max_tokens** to limit response length
3. **Batch related requests** in sequence
4. **Cache repeated responses** locally

<br>

# Integration Examples

<br>

# Rails Application

<br>

```ruby
# app/services/ai_service.rb
class AiService
  def initialize
    @client = Nuntius::Client.new
  end

  def generate_content(prompt)
    @client.generate_text(prompt)
  rescue Nuntius::Error => e
    Rails.logger.error "AI Service Error: #{e.message}"
    "Sorry, I couldn't generate content right now."
  end
end
```

<br>

# Sinatra Application

<br>

```ruby
require 'sinatra'
require 'nuntius'

Nuntius.load_env

post '/generate' do
  client = Nuntius::Client.new
  response = client.generate_text(params[:prompt])
  { response: response }.to_json
rescue Nuntius::Error => e
  status 500
  { error: e.message }.to_json
end
```
