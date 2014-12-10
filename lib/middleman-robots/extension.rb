module Middleman
  module Robots
    class Extension < ::Middleman::Extension

      def initialize(app, options_hash = {}, &block)
        super

        build_dir = File.join(app.root, app.build_dir)
        app.after_build do

        end
      end

    end
  end
end
