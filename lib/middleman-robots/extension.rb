require 'middleman-robots/group'

module Middleman
  module Robots
    # Robots Extension Class
    class Extension < ::Middleman::Extension
      option :rules, [], 'List of rules about sitemap.xml'
      option :sitemap, false, 'URI of sitemap.xml'

      def initialize(app, options_hash = {}, &block)
        super
        build_dir = app.config.build_dir
        content = data(options.rules, options.sitemap)

        app.after_build do
          File.open(File.join(build_dir, 'robots.txt'), 'w') do |file|
            file.puts(content)
          end
          logger.info '== middleman-robots: robots.txt created =='
        end
      end

      def data(rules, sitemap_uri)
        blocks  = block_text(rules)
        sitemap = sitemap_text(sitemap_uri)

        if !blocks.empty? && !sitemap.empty?
          blocks + "\n" + sitemap
        elsif !blocks.empty?
          blocks
        elsif !sitemap.empty?
          sitemap
        else
          ''
        end
      end

      def block_text(rules)
        return '' if rules.empty?
        data = []
        rules.each do |rule|
          data << Group.new(rule).text
        end
        data.join("\n")
      end

      def sitemap_text(path)
        path ? "Sitemap: #{path}" : ''
      end
    end
  end
end
