require 'minitest/autorun'
require_relative '../lib/middleman-robots/generator.rb'

class TestGenerator < MiniTest::Test
  def test_process
    sitemap_uri = 'http://example.com/sitemap.xml'
    generator = Middleman::Robots::Generator.new(rules, sitemap_uri)
    assert_equal expected, generator.process
  end

  private

  def rules
    [
      {
        user_agent: 'Googlebot',
        disallow: %w[
          tmp/*
          /something/dir/file_disallow.html
        ],
        allow: %w[
          allow/*
          /something/dir/file_allow.html
        ]
      },
      {
        user_agent: 'Googlebot-Image',
        disallow: %w[
          tmp/*
          /something/dir/file_disallow.html
        ],
        allow: %w[
          allow/*
          /something/dir/file_allow.html
        ]
      }
    ]
  end

  def expected
    "User-Agent: Googlebot
Disallow: /tmp/*
Disallow: /something/dir/file_disallow.html
Allow: /allow/*
Allow: /something/dir/file_allow.html

User-Agent: Googlebot-Image
Disallow: /tmp/*
Disallow: /something/dir/file_disallow.html
Allow: /allow/*
Allow: /something/dir/file_allow.html

Sitemap: http://example.com/sitemap.xml"
  end
end
