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
          @groups = @rules.map { |rule| Block.new(rule) }
        end

        def text
          @groups.map(&:text).join "\n\n"
        end
      end
    end
  end
end
