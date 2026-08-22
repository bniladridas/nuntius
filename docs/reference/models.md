# Models

<br>

Nuntius maps Ruby symbols to Gemini `generateContent` text model IDs.

<br>

| Symbol | Model | Use |
| --- | --- | --- |
| `:flash_latest` | `gemini-flash-latest` | Moving Flash alias |
| `:flash_3_7` | `gemini-3.7-flash` | Gemini 3.7 Flash, default |
| `:flash_3_7` | `gemini-3.7-flash` | Gemini 3.7 Flash, default |
| `:flash_3_6` | `gemini-3.6-flash` | Gemini 3.6 Flash, fallback |
| `:flash_3_5` | `gemini-3.5-flash` | Gemini 3.5 Flash, stable baseline |
| `:flash_3_5_lite` | `gemini-3.5-flash-lite` | Gemini 3.5 Flash-Lite |
| `:flash_3_preview` | `gemini-3-flash-preview` | Gemini 3 Flash preview |
| `:pro_3_1_preview` | `gemini-3.1-pro-preview` | Gemini 3.1 Pro preview |
| `:flash_3_1_lite` | `gemini-3.1-flash-lite` | Gemini 3.1 Flash Lite |
| `:pro_2_5` | `gemini-2.5-pro` | Gemini 2.5 Pro |
| `:flash_2_5` | `gemini-2.5-flash` | Gemini 2.5 Flash |
| `:flash_2_0` | `gemini-2.0-flash` | Gemini 2.0 Flash |
| `:flash` | `gemini-3.7-flash` | Short alias, default |
| `:flash_fallback` | `gemini-3.6-flash` | Short alias, fallback |
| `:flash` | `gemini-3.5-flash` | Short alias |
| `:flash_lite` | `gemini-3.1-flash-lite` | Short alias, lightweight |
| `:pro_2_0` | `gemini-2.0-flash` | Legacy alias |

<br>

# Usage

<br>

```ruby
require 'nuntius'

client = Nuntius::Client.new
fast_client = Nuntius::Client.new(model: :flash)
```

<br>

Unknown model symbols fall back to `:flash` (`gemini-3.7-flash`).

<br>

Deprecated `1.5` and retired Pro aliases (`:pro`, `:pro_latest`, `:pro_3_1_preview`, `:pro_2_5`, `:pro_3_preview`) log a warning and also fall back to `:flash`. Pro requires billing (Free-Tier quota `0`).

<br>

# Options

<br>

Generation options are passed per request:

<br>

```ruby
client.generate_text(
  'Explain Ruby fibers',
  temperature: 0.3,
  max_tokens: 500,
  top_p: 0.9,
  top_k: 40
)
```

<br>

Use lower temperature for factual output and higher temperature for more varied responses.
