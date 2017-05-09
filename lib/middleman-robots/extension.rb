require 'middleman-robots/generator'
require 'tempfile'

module Middleman
  module Robots
    # Robots Extension Class
    class Extension < ::Middleman::Extension
      option :rules, [], 'List of rules about sitemap.xml'
      option :sitemap, false, 'URI of sitemap.xml'

      def manipulate_resource_list(resources)
        tmp_path = File.expand_path('../../../tmp/robots/robots.txt', __FILE__)
        File.open(tmp_path, 'w+') do |f|
          f.puts(Generator.new(options.rules, options.sitemap).process)
        end

        robots = Middleman::Sitemap::Resource.new(
          app.sitemap,
          'robots.txt',
          tmp_path
        )

        logger.info '== middleman-robots: robots.txt added to resources =='
        resources << robots
      end
    end
  end
end
