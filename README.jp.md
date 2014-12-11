# Middleman::Robots

[![Gem Version](https://badge.fury.io/rb/middleman-robots.svg)](http://badge.fury.io/rb/middleman-robots)
[![Build Status](https://travis-ci.org/yterajima/middleman-robots.svg?branch=master)](https://travis-ci.org/yterajima/middleman-robots)

`middleman-robots` は [Middleman](http://middlemanapp.com/) の拡張機能です。 build 実行時に `config.rb` に記述されたルールに基いて `robots.txt` を作ります。

## Installation

Gemfile に次の行を追加してください:

```ruby
gem 'middleman-robots'
```

コマンドを実行します:

    $ bundle

Gemfile を使わずにインストールする場合は次のコマンドを実行してください:

    $ gem install middleman-robots

## 使い方

基本的な使い方です:

```ruby
# config.rb
configure :build do
  activate :robots, :rules => [
    {:user_agent => '*', :allow => %w(/)}
  ],
  :sitemap => "http://example.com/sitemap.xml"
end
```

作成される `robots.txt`:

```
User-Agent: *
Allow: /

Sitemap: http://example.com/sitemap.xml

```


オプションには `:rules` {[`:user_agent`(string), `:allow`(array), `:disallow`(array)]} と `:sitemap` を指定できます。すべてのオプションを指定すると次のようになります:

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

作成される `robots.txt`:

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

