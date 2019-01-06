module Middleman
  module Robots
    # Robots Group Class
    #
    # Group class generate block in robots.txt
    class Group
      attr_reader :user_agent, :disallow, :allow

      def initialize(rule)
        @user_agent = generate_user_agent(rule)
        @disallow   = generate_disallow(rule)
        @allow      = generate_allow(rule)
      end

      def text
        group = []
        group << "User-Agent: #{@user_agent}" unless @user_agent.empty?
        group << @disallow.collect { |item| "Disallow: #{item}" }.join("\n") if @disallow.length.positive?
        group << @allow.collect { |item| "Allow: #{item}" }.join("\n") if @allow.length.positive?
        group.join("\n") + "\n"
      end

      private

      def generate_user_agent(rule)
        return '*' unless rule.key?('user-agent') || rule.key?(:user_agent)

        rule[:user_agent] || rule['user-agent']
      end

      def generate_disallow(rule)
        paths = []
        return paths unless rule.key?(:disallow)

        rule[:disallow].each do |path|
          paths << File.join('/', path)
        end
        paths
      end

      def generate_allow(rule)
        paths = []
        return paths unless rule.key?(:allow)

        rule[:allow].each do |path|
          paths << File.join('/', path)
        end
        paths
      end
    end
  end
end
