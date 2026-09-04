<p align="center">
  <img src="https://raw.githubusercontent.com/palmshed/nuntius/main/.github/assets/thumbnail.png" alt="nuntius" width="100%">
</p>

# Nuntius
<img src="website/assets/nuntius-header.png" alt="Nuntius" width="100%">

<br>

![Ruby](https://img.shields.io/badge/ruby-%3E%3D%203.3-cc342d?style=flat-square)
[![License](https://img.shields.io/badge/license-MIT-2f4858?style=flat-square)](LICENSE)
![Tests](https://img.shields.io/badge/tests-passing-2e7d32?style=flat-square)

<br>

Ruby client for Gemini `generateContent`. Includes a CLI and a PR review app.

<br>

# Installation

<br>

```bash
gem install nuntius-rb
```

<br>

With Bundler:

<br>

```ruby
gem 'nuntius-rb', require: 'nuntius'
```

<br>

The package is published as `nuntius-rb`. The runtime entrypoint is `nuntius`.

<br>

Set your API key in `.env`:

<br>

```
GEMINI_API_KEY=your_api_key
```

<br>

> [!NOTE]
> Ensure your API key is kept secure and not committed to version control.

<br>

# Usage

<br>

# Basic Setup

<br>

```ruby
require 'nuntius'
Nuntius.load_env

client = Nuntius::Client.new
puts client.generate_text('Write a haiku about Ruby')
```

<br>

Use a different model when needed:

<br>

```ruby
fast_client = Nuntius::Client.new(model: :flash)
puts fast_client.generate_text('Explain Ruby in one sentence')
```

<br>

# generateContent Text Models: Flash family (Free-Tier)

<br>

| Key | ID |
| --- | --- |
| `:flash_latest` | `gemini-flash-latest` |
| `:flash_3_7` | `gemini-3.7-flash` |
| `:flash_3_6` | `gemini-3.6-flash` |
| `:flash_3_5` | `gemini-3.5-flash` |
| `:flash_3_5_lite` | `gemini-3.5-flash-lite` |
| `:flash_3_preview` | `gemini-3-flash-preview` |
| `:flash_3_1_lite` | `gemini-3.1-flash-lite` |
| `:flash_2_5` | `gemini-2.5-flash` |
| `:flash_2_0` | `gemini-2.0-flash` |

<br>

Short aliases: `:flash` uses `gemini-3.7-flash` (default), `:flash_fallback` uses `gemini-3.6-flash`, and `:flash_lite` uses `gemini-3.1-flash-lite`. Legacy `:pro_2_0` maps to `gemini-2.0-flash`. Pro models (`gemini-pro-latest`, `gemini-3.1-pro-preview`, `gemini-2.5-pro`) are retired for Free-Tier, as they resolve to the `3.1-pro` backend and hit quota `0`. Use billing to enable.

<br>

The gem does not wrap embeddings, Imagen, or Veo APIs.

<br>

# Capabilities

<br>

Nuntius supports text generation, chat, image input for `generateContent`, model aliases, safety settings, API key masking, retries, and a local CLI.

<br>

# Handling Errors

<br>

Client validation and API failures raise `Nuntius::Error` with a readable message.
HTTP 429 responses are retried automatically up to three times with exponential backoff.

<br>

```ruby
begin
  response = client.generate_text('Hello')
  puts response
rescue Nuntius::Error => err
  warn "Generation failed: #{err.message}"
end
```

<br>

Common failures include:

<br>

- Missing or invalid `GEMINI_API_KEY`
- Empty prompts
- Prompts over the configured maximum length
- Gemini API errors returned by the service
- Network errors raised by HTTParty

<br>

# Retries

<br>

Rate-limit responses (`429`) are retried up to three times with waits of 5, 10, and 20 seconds.

<br>

# Timeouts

<br>

Requests use a 30 second HTTParty timeout.

<br>

# Logging

<br>

```ruby
require 'nuntius'

Nuntius::Client.logger.level = Logger::INFO
client = Nuntius::Client.new
```

<br>

# Requirements

<br>

Ruby 3.3 or later. Linux and macOS are tested.

<br>

# Environment Variables

<br>

```bash
GEMINI_API_KEY=your_api_key_here
```

<br>

# Repo CLI

<br>

```bash
./bin/gemini test
./bin/gemini generate "Your prompt"
./bin/gemini chat
```

<br>

# Local Development & Testing

<br>

```bash
bundle exec rake test          # Run tests
bundle exec rake docs          # Build API docs
gem build nuntius-rb.gemspec
```

<br>

# Review App

<br>

Nuntius Review is the PR review app in this repo. It defaults to `gemini-3.7-flash` (fallback `gemini-3.6-flash` for large diffs). Override with `NUNTIUS_GEMINI_MODEL`. Retrieval context is off unless enabled in `nuntius/config.yaml`. Only verified `generateContent` Flash models are listed as supported. See API `GET /v1beta/models` for existence, not quota.

<br>

For setup details, see [`nuntius/Nuntius.md`](nuntius/Nuntius.md).

<br>

# Examples

<br>

# Text Generation

<br>

```ruby
client = Nuntius::Client.new
puts client.generate_text('Write a haiku about Ruby')
```

<br>

# Image Analysis

<br>

```ruby
image_data = Base64.strict_encode64(File.binread('path/to/image.jpg'))
puts client.generate_image_text(image_data, 'Describe this image')
```

<br>

# Chat

<br>

```ruby
messages = [
  { role: 'user', content: 'Hello!' },
  { role: 'model', content: 'Hi there!' },
  { role: 'user', content: 'Tell me about Ruby.' }
]
puts client.chat(messages, system_instruction: 'Be concise.')
```

<br>

# Documentation

<br>

| Need | Link |
| --- | --- |
| Start | [`Quickstart`](docs/start/quickstart.md) |
| API | [`Reference`](docs/reference/api.md) |
| Recipes | [`Cookbook`](docs/reference/cookbook.md) |
| Practice | [`Best practices`](docs/guides/practices.md) |
| Automation | [`Workflows`](docs/guides/workflows.md) |
| Project | [`Contributing`](docs/CONTRIBUTING.md) |

<br>

# Contributing

<br>

Fork the repo and open a pull request.

<br>

# License

<br>

MIT → see [`LICENSE`](LICENSE).

<br>

<p align="center">
  <a href="https://github.com/apps/nuntius-review">
    <img src="website/favicon.svg" alt="Nuntius Review app" width="96">
  </a>

<br>

  <a href="https://github.com/apps/nuntius-review"><code>Nuntius Review</code></a>
</p>
