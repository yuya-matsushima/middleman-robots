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
        blocks  = block_text
        sitemap = sitemap_text

        if !blocks.empty? && !sitemap.empty?
          blocks + "\n" + sitemap
        elsif !blocks.empty?
          blocks
        elsif !sitemap.empty?
          sitemap
        else
          ''
        end
      end

      private

      def block_text
        return '' if @rules.empty?
        data = []
        @rules.each do |rule|
          data << Group.new(rule).text
        end
        data.join("\n")
      end

      def sitemap_text
        @sitemap_uri ? "Sitemap: #{@sitemap_uri}" : ''
      end
    end
  end
end
