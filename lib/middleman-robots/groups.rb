require 'middleman-robots/group'

module Middleman
  module Robots
    # Groups
    #
    # Collection of ::Middleman::Robots::Group
    class Groups
      def initialize(rules)
        @rules = rules
        @groups = @rules.map { |rule| Group.new(rule) }
      end

      def text
        @groups.map(&:text).join "\n\n"
      end
    end
  end
end
