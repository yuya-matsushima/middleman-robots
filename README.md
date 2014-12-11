# Middleman::Robots

[![Gem Version](https://badge.fury.io/rb/middleman-robots.svg)](http://badge.fury.io/rb/middleman-robots)
[![Build Status](https://travis-ci.org/yterajima/middleman-robots.svg?branch=master)](https://travis-ci.org/yterajima/middleman-robots)

`middleman-robots` is an extension of [Middleman](http://middlemanapp.com/). This can create `robots.txt` when build.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'middleman-robots'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middleman-robots

## Usage

Basic usage:

```ruby
# config.rb
configure :build do
  activate :robots, :rules => [
    {:user_agent => '*', :allow => %w(/)}
  ],
  :sitemap => "http://example.com/sitemap.xml"
end
```

Created `robots.txt`:

```
User-Agent: *
Allow: /

Sitemap: http://example.com/sitemap.xml

```

You can use options, `:rules` {[`:user_agent`(string), `:allow`(array), `:disallow`(array)]} and `:sitemap`. Like this:

```ruby
# config.rb
configure :build do
  activate :robots,
    :rules => [
      {
        :user_agent => 'Googlebot',
        :disallow =>  %w(tmp/ /something/dir/file_disallow.html),
        :allow =>  %w(allow/ /something/dir/file_allow.html)
      },
      {
        :user_agent => 'Googlebot-Image',
        :disallow =>  %w(tmp/ /something/dir/file_disallow.html),
        :allow =>  %w(allow/ /something/dir/file_allow.html)
      }
    ],
    :sitemap => "http://example.com/sitemap.xml"
end
```

Created `robots.txt`:

```
User-Agent: Googlebot
Disallow: /tmp/
Disallow: /something/dir/file_disallow.html
Allow: /allow/
Allow: /something/dir/file_allow.html

User-Agent: Googlebot-Image
Disallow: /tmp/
Disallow: /something/dir/file_disallow.html
Allow: /allow/
Allow: /something/dir/file_allow.html

Sitemap: http://example.com/sitemap.xml

```

## Contributing

1. Fork it ( https://github.com/yterajima/middleman-robots/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

