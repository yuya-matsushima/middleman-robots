module Middleman
  module Robots
    class Extension < ::Middleman::Extension
      option :rules, [], 'List of rules about sitemap.xml'
      option :sitemap, false, 'Relative path of sitemap.xml'

      def initialize(app, options_hash = {}, &block)
        super

        data = rules(options.rules)

        build_dir = app.build_dir
        app.after_build do
          File.open(File.join(build_dir, "robots.txt"), "w") do |file|
            file.puts(data)
          end
        end
      end

      def rules(rules)
        return '' if rules.empty?

        data = []
        rules.each do |rule|
          if (rule["user-agent"])
            data << "user-agent: #{rule["user-agent"]}"
          end
        end

        data.join("\n")
      end
    end
  end
end
