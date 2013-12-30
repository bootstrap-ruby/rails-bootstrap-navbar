# Rails Bootstrap Navbar

[![Gem Version](https://badge.fury.io/rb/rails_bootstrap_navbar.png)](http://badge.fury.io/rb/rails_bootstrap_navbar)
[![Build Status](https://secure.travis-ci.org/bootstrap-ruby/rails-bootstrap-navbar.png)](http://travis-ci.org/bootstrap-ruby/rails-bootstrap-navbar)
[![Dependency Status](https://gemnasium.com/bootstrap-ruby/rails-bootstrap-navbar.png)](https://gemnasium.com/bootstrap-ruby/rails-bootstrap-navbar)
[![Code Climate](https://codeclimate.com/github/bootstrap-ruby/rails-bootstrap-navbar.png)](https://codeclimate.com/github/bootstrap-ruby/rails-bootstrap-navbar)

Easily generate a [Twitter Bootstrap navbar](http://twitter.github.io/bootstrap/components.html#navbar) in your Rails app

## Installation

Add this line to your application's Gemfile:

    gem 'rails_bootstrap_navbar'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_bootstrap_navbar

## Requirements

The necessary files from Bootstrap >= 2.0 have to be included separately, they are not part of this gem.

At least the CSS files for the navbar are required, and the JS files for dropdowns and responsive features, if you want to use those in the navbar.

## Usage

The gem [bootstrap-navbar](https://github.com/bootstrap-ruby/bootstrap-navbar) is used to generate the HTML. Please refer to the gem's [README](https://github.com/bootstrap-ruby/bootstrap-navbar/blob/master/README.md) and the following Wiki entries for detailed instructions on how to generate the navbar:

[Usage with Bootstrap 2.x](https://github.com/bootstrap-ruby/bootstrap-navbar/wiki/Usage-with-Bootstrap-2.x)

[Usage with Bootstrap 3.x](https://github.com/bootstrap-ruby/bootstrap-navbar/wiki/Usage-with-Bootstrap-3.x)

## Acknowledgements

Thanks to [Jules Copeland](https://github.com/julescopeland) for the initial version of this gem!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
