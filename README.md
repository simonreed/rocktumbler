# Rocktumbler

[ ![Codeship Status for simonreed/rocktumbler](https://codeship.com/projects/f0992010-34aa-0133-cb4b-0afba22710e8/status?branch=master)](https://codeship.com/projects/100585)

Rocktumbler is a gem that will take your existing Gemfile and rewrite it to ensure that it remains formatted and consistent.

It enforces a style to your Gemfile to make it easy to read and understand your Gemfile.

Single quotes.
Ruby 1.9 hash syntax.
Space Indentation.
Sort gems alphabetically.
Use block form for groups.

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

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rocktumbler'
```

And then execute:

    $ tumble

This will then rewrite your Gemfile making sure that you use single quotes and gives a brief description of what each gem does.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

TODO: Add tests!

## Contributing

1. Fork it ( https://github.com/simonreed/rocktumbler/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
