module Middleman
  module Robots
    module Generators
      class SitemapUri
        attr_accessor :uri

        def initialize(uri)
          @uri = uri
        end

        def text
          return nil if uri.nil?

          "Sitemap: #{uri}"
        end
      end
    end
  end
end
