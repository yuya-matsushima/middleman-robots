require 'middleman-robots/generators/blocks'
require 'middleman-robots/generators/sitemap_uri'

module Middleman
  module Robots
    # Robots Text Generator Class
    class Generator
      attr_accessor :rules, :sitemap_uri

      def initialize(rules, sitemap_uri)
        @rules = rules
        @sitemap_uri = sitemap_uri
      end

      def process
        text = [
          Generators::Blocks.new(rules).text,
          Generators::SitemapUri.new(sitemap_uri).text
        ].compact.join "\n\n"

        text + "\n" unless text.nil?
      end
    end
  end
end
