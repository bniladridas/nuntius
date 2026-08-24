source 'https://rubygems.org'

# Specify your gem's dependencies in nuntius-rb.gemspec
gemspec

# Additional dependencies (Ruby 3.4+ where bigdecimal is separate)
gem 'bigdecimal', '~> 4.0'

# Development and test dependencies
group :development, :test do
  # Security and development tools
  gem 'bundler-audit', '~> 0.9', require: false
  gem 'simplecov', '~> 0.22.0', require: false
  gem 'simplecov-lcov', '~> 0.9.0', require: false
end

gem "mocha", "~> 3.0", groups: [:development, :test]
gem "minitest-reporters", "1.8.0", :groups => [:development, :test]
gem "webmock", "~> 3.19", :groups => [:test]
gem "thor", "~> 1.3", :groups => [:development]
