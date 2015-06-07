module Middleman
  module Robots
    # Robots Extension Class
    #
    # Create robots.txt when `$ middleman build`
    class Extension < ::Middleman::Extension
      option :rules, [], 'List of rules about sitemap.xml'
      option :sitemap, false, 'URI of sitemap.xml'

      def initialize(app, options_hash = {}, &block)
        super
        build_dir = app.config.build_dir

        data = rules(options.rules) + sitemap(options.sitemap)
        data.gsub!(/\n+$/, "\n")

        app.after_build do
          File.open(File.join(build_dir, 'robots.txt'), 'w') do |file|
            file.puts(data)
          end
          logger.info '== middleman-robots: robots.txt created =='
        end
      end

      def rules(rules)
        return '' if rules.empty?
        data = []
        rules.each do |rule|
          row = []
          row << user_agent(rule)
          row << disallow(rule)
          row << allow(rule)
          row.compact!
          data << row.join("\n") + "\n\n" if row.length > 0
        end
        data.join('')
      end

      def user_agent(rule)
        return unless rule.key?('user-agent') || rule.key?(:user_agent)
        user_agent = rule[:user_agent] || rule['user-agent']
        "User-Agent: #{user_agent}"
      end

      def disallow(rule)
        return unless rule.key?(:disallow)
        lines = []
        rule[:disallow].each do |path|
          path = File.join('/', path) unless /^\// =~ path
          lines << "Disallow: #{path}"
        end
        lines
      end

      def allow(rule)
        return unless rule.key?(:allow)
        lines = []
        rule[:allow].each do |path|
          path = File.join('/' + path) unless /^\// =~ path
          lines << "Allow: #{path}"
        end
        lines
      end

      def sitemap(path)
        path ? "Sitemap: #{path}" : ''
      end
    end
  end
end
