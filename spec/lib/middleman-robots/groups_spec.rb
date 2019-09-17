require 'middleman-robots/groups'

RSpec.describe Middleman::Robots::Groups do
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
      klass = Middleman::Robots::Groups.new(rules)
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
