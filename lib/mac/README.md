# Mac Utils

<br>

This module provides macOS-specific utilities for the nuntius-rb gem.

<br>

# Methods

<br>

# `Nuntius::MacUtils.mac?`

<br>

Returns `true` if the current platform is macOS (Darwin), `false` otherwise.

<br>

# `Nuntius::MacUtils.version`

<br>

Returns the macOS version string (e.g., "14.1") if running on macOS, `nil` otherwise.

<br>

# Usage

<br>

```ruby
require 'mac/mac_utils'

if Nuntius::MacUtils.mac?
  puts "Running on macOS version #{Nuntius::MacUtils.version}"
end
```
