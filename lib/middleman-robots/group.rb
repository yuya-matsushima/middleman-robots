module Middleman
  module Robots
    # Group
    #
    # Generating Block in robots.txt
    class Group
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
        user_agent = rule[:user_agent] || rule['user-agent']  || '*'
        "User-Agent: #{user_agent}"
      end

      def disallow
        return nil unless rule.key? :disallow

        rule[:disallow].map { |path| "Disallow: #{File.join('/', path)}" }
      end

      def allow
        return nil unless rule.key? :allow

        rule[:allow].map { |path| "Allow: #{File.join('/', path)}" }
      end
    end
  end
end
