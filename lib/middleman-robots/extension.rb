require 'middleman-robots/generator'

module Middleman
  module Robots
    # Robots Extension Class
    class Extension < ::Middleman::Extension
      option :rules, [], 'List of rules about sitemap.xml'
      option :sitemap, false, 'URI of sitemap.xml'

      def initialize(app, options_hash = {}, &block)
        super
      end

      def manipulate_resource_list(resources)
        data   = Generator.new(options.rules, options.sitemap).process
        robots = Middleman::Sitemap::Resource.new(
          app.sitemap,
          'robots.txt',
          File.join(template_dir, 'robots.txt.erb')
        )
        robots.add_metadata(locals: {robots: data})

        logger.info '== middleman-robots: robots.txt added to resources =='
        resources << robots
      end

      def template_dir
        File.expand_path(File.join('..', 'templates'), __FILE__)
      end
    end
  end
end
