require 'middleman-robots/generators/blocks'

RSpec.describe Middleman::Robots::Generators::Blocks do
  let(:rules) do
    [
      {
        user_agent: 'GoogleBot',
        disallow: %w[tmp/* /someting/dir/disallow.html],
        allow: %w[allow/* /someting/dir/allow.html]
      },
      {
        user_agent: 'GoogleBot-Image',
        disallow: %w[tmp/* /someting/dir/disallow.html],
        allow: %w[allow/* /someting/dir/allow.html]
      }
    ]
  end

  describe '#text' do
    subject do
      klass = described_class.new(rules)
      klass.text
    end

    let(:expected) do
      expected =<<~ROBOTS
        User-Agent: GoogleBot
        Disallow: /tmp/*
        Disallow: /someting/dir/disallow.html
        Allow: /allow/*
        Allow: /someting/dir/allow.html

        User-Agent: GoogleBot-Image
        Disallow: /tmp/*
        Disallow: /someting/dir/disallow.html
        Allow: /allow/*
        Allow: /someting/dir/allow.html
      ROBOTS
      expected.chomp
    end

    it { is_expected.to eq expected.chomp }
  end
end
