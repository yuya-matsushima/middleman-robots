# frozen_string_literal: true

require 'middleman-core'
require 'middleman-robots/version'

::Middleman::Extensions.register(:robots) do
  require 'middleman-robots/extension'
  ::Middleman::Robots::Extension
end
