require 'middleman-robots/group'

module Middleman
  module Robots
    # Robots Text Generator Class
    class Generator
      def initialize(rules, sitemap_uri)
        @rules = rules
        @sitemap_uri = sitemap_uri
      end

      def process
        [block_text, sitemap_text].join("\n") + "\n"
      end

      private

      def block_text
        return '' if @rules.empty?

        @rules.map { |rule| Group.new(rule).text }.join("\n")
      end

      def sitemap_text
        @sitemap_uri ? "Sitemap: #{@sitemap_uri}" : ''
      end
    end
  end
end
