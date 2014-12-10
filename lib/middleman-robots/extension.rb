module Middleman
  module Robots
    class Extension < ::Middleman::Extension

      def initialize(app, options_hash = {}, &block)
        super

        build_dir = app.build_dir
        app.after_build do
          File.open(File.join(build_dir, "robots.txt"), "w") do |file|
            file.puts("")
          end
        end
      end

    end
  end
end
