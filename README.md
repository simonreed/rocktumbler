# Rocktumbler

[![Build Status](https://travis-ci.org/simonreed/rocktumbler.svg)](https://travis-ci.org/simonreed/rocktumbler) [![Code Climate](https://codeclimate.com/github/simonreed/rocktumbler/badges/gpa.svg)](https://codeclimate.com/github/simonreed/rocktumbler)

Rocktumbler is a gem that will take your existing Gemfile and ensure that it remains formatted and consistent.

It enforces a style to your Gemfile to make it easy to read and understand your Gemfile. Including :

* Single quotes.
* Ruby 1.9 hash syntax.
* 2 Space Indentation.
* Sort gems alphabetically.
* Organise groups around the block form.
* Add Gem description and url, making it easier to document what a gem is used for (optional).

It will produce a Gemfile that is compliant with the default config for Rubocop.

## Example

Before

```ruby
source "https://rubygems.org"
  gem 'pg'
gem "rocktumbler"
gem 'pry', :require => 'pry', :group => 'development'
gem 'rubocop',                 group: 'development'
```

After

```ruby
source 'https://rubygems.org'

gem 'pg'
gem 'rocktumbler'

group :development do
  gem 'pry', require: 'pry'
  gem 'rubocop'
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rocktumbler'
```

And then execute:

    $ tumble

This will then rewrite your Gemfile giving you a fresh, clean and consistent Gemfile.

## CLI Options

```
Usage: tumble [options]

Specific options:
    -i, --info                       Display gem info comment.
    -d, --homepage                   Display gem homepage comment.
    -s, --skip-write                 Skip writing of Gemfile
    -V, --verbose                    Display formatted output to STDOUT

Common options:
    -h, --help                       Show this message
        --version                    Show version
```

### Gem Info Comments

If you wish to display Gem info within your Gemfile to aid readablility you can specify the `-i` or `--info` option on the CLI. The gem homepage url can be added with the `-d` or `--homepage` option.

`tumble --info --homepage`

will give you :

```ruby
source 'https://rubygems.org'

# Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/]
# https://bitbucket.org/ged/ruby-pg
gem 'pg'
# Polish your Gemfile to make sure it remains consistent.
# https://github.com/simonreed/rocktumbler
gem 'rocktumbler'

group :development do
  # An IRB alternative and runtime developer console
  # http://pryrepl.org
  gem 'pry', require: 'pry'
  # Automatic Ruby code style checking tool.
  # http://github.com/bbatsov/rubocop
  gem 'rubocop'
end
```

## Bundler integration

All generated Gemfiles are parsed and verified against the original Gemfile using Bundler to ensure the Bundler configuration remains unchanged. No need to worry about Gems going missing.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

TODO: Add more test coverage!

## Contributing

1. Fork it ( https://github.com/simonreed/rocktumbler/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
