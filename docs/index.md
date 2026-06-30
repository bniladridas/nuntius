# Nuntius

<br>

A Ruby interface to Google's Gemini AI models, designed for simplicity, security, and power.

<br>

# Quick Start

<br>

Install the gem:

<br>

```bash
gem install nuntius-rb --pre
```

<br>

Set your API key:

<br>

```bash
export GEMINI_API_KEY="your-api-key-here"
```

<br>

Generate text:

<br>

```ruby
require 'nuntius'

client = Nuntius::Client.new
response = client.generate_text("Hello, Gemini!")
puts response
```

<br>

# PR Review

<br>

[`Nuntius`](reference/nuntius.md) automates code reviews using Gemini AI, analyzing PRs and providing feedback.

<br>

# Documentation

<br>

- [`Quick Start`](start/quickstart.md)
- [`API Reference`](reference/api.md)
- [`Nuntius`](reference/nuntius.md)
- [`Guides`](guides/community.md)
- [`Testing`](reference/testing.md)

<br>

# Links

<br>

- [RubyGems](https://rubygems.org/gems/nuntius-rb)
- [Issues](https://github.com/palmshed/nuntius/issues)
- [Discussions](https://github.com/palmshed/nuntius/discussions)
- [`Security`](https://github.com/palmshed/nuntius/blob/main/.github/SECURITY.md)
- [`License`](https://github.com/palmshed/nuntius/blob/main/LICENSE)
