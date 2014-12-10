module Middleman
  module Robots
    class Extension < ::Middleman::Extension
      option :rules, [], 'List of rules about sitemap.xml'
      option :sitemap, false, 'URI of sitemap.xml'

      def initialize(app, options_hash = {}, &block)
        super

        data = rules(options.rules) + sitemap(options.sitemap)
        data.gsub!(/\n+$/, "\n")

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
          row = []
          if (rule["user-agent"])
            row << "user-agent: #{rule["user-agent"]}"
          end

          if (rule[:disallow])
            rule[:disallow].each do |path|
              path = "/" + path unless /^\// =~ path
              row << "Disallow: #{path}"
            end
          end

          if (rule[:allow])
            rule[:allow].each do |path|
              path = "/" + path unless /^\// =~ path
              row << "Allow: #{path}"
            end
          end

          data << row.join("\n") + "\n\n" if row.length > 0
        end

        data.join('')
      end

      def sitemap(path)
        path ? "Sitemap: #{path}" : ""
      end
    end
  end
end
