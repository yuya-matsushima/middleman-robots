require 'middleman-robots/generator'
require 'tempfile'

module Middleman
  module Robots
    # Robots Extension Class
    class Extension < ::Middleman::Extension
      option :rules, [], 'List of rules about sitemap.xml'
      option :sitemap, false, 'URI of sitemap.xml'

      def manipulate_resource_list(resources)
        tf = Tempfile.open('middleman-robots')
        tf.puts(Generator.new(options.rules, options.sitemap).process)

        robots = Middleman::Sitemap::Resource.new(
          app.sitemap,
          'robots.txt',
          tf.path
        )
        tf.close

        logger.info '== middleman-robots: robots.txt added to resources =='
        resources << robots
      end
    end
  end
end
