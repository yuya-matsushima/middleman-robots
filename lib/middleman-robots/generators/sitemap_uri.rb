# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

module Middleman
  module Robots
    module Generators
      class SitemapUri
        attr_accessor :uri

        def initialize(uri)
          @uri = uri
        end

        def text
          return nil if uri.blank?
          raise ArgumentError, 'sitemap_uri must be string or nil' unless uri.is_a? String

          "Sitemap: #{uri}"
        end
      end
    end
  end
end
