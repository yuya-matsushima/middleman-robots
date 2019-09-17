require 'active_support/core_ext/object/blank'

module Middleman
  module Robots
    module Generators
      # Block
      #
      # Generating Block in robots.txt
      class Block
        attr_accessor :rule

        def initialize(rule)
          @rule = rule
        end

        def text
          [
            user_agent,
            disallow,
            allow,
          ].compact.join("\n")
        end

        private

        def user_agent
          user_agent = rule[:user_agent].presence || rule['user-agent'].presence || '*'
          unless user_agent.is_a? String || user_agent.nil?
            raise ArgumentError.new('`user_agent` or `user-agent` option must be String')
          end

          "User-Agent: #{user_agent}"
        end

        def disallow
          return nil if !rule.key?(:disallow) || rule[:disallow].blank?
          unless rule[:disallow].is_a? Array
            raise ArgumentError.new('`disallow` option must be Array')
          end

          rule[:disallow].map { |path| "Disallow: #{File.join('/', path)}" }
        end

        def allow
          return nil if !rule.key?(:allow) || rule[:allow].blank?
          unless rule[:allow].is_a? Array
            raise ArgumentError.new('`allow` option must be Array')
          end

          rule[:allow].map { |path| "Allow: #{File.join('/', path)}" }
        end
      end
    end
  end
end
