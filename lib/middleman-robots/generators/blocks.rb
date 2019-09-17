# frozen_string_literal: true

require 'active_support/core_ext/object/blank'
require 'middleman-robots/generators/block'

module Middleman
  module Robots
    module Generators
      # Blocks
      #
      # Collection of ::Middleman::Robots::Generators::Block
      class Blocks
        def initialize(rules)
          @rules = rules
          @groups = @rules.map { |rule| Block.new(rule) } if @rules.present?
        end

        def text
          return nil if @groups.nil?

          @groups.map(&:text).join "\n\n"
        end
      end
    end
  end
end
