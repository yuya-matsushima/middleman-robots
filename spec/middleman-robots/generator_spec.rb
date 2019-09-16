require_relative '../../lib/middleman-robots/generator.rb'

RSpec.describe Middleman::Robots::Generator do
  before do
    @klass = Middleman::Robots::Generator.new(rules, sitemap_url)
  end

  describe '#process' do
    let(:rules) do
      [
        {
          user_agent: 'Googlebot',
          disallow: %w[
            tmp/*
            /something/dir/file_disallow.html
          ],
          allow: %w[
            allow/*
            /something/dir/file_allow.html
          ]
        },
        {
          user_agent: 'Googlebot-Image',
          disallow: %w[
            tmp/*
            /something/dir/file_disallow.html
          ],
          allow: %w[
            allow/*
            /something/dir/file_allow.html
          ]
        }
      ]
    end
    let(:sitemap_url) { 'http://example.com/sitemap.xml' }
    let(:expected) do
      <<~ROBOTS
        User-Agent: Googlebot
        Disallow: /tmp/*
        Disallow: /something/dir/file_disallow.html
        Allow: /allow/*
        Allow: /something/dir/file_allow.html

        User-Agent: Googlebot-Image
        Disallow: /tmp/*
        Disallow: /something/dir/file_disallow.html
        Allow: /allow/*
        Allow: /something/dir/file_allow.html

        Sitemap: http://example.com/sitemap.xml
      ROBOTS
    end

    subject do
      @klass = Middleman::Robots::Generator.new(rules, sitemap_url)
      @klass.process
    end

    it { is_expected.to eq expected }
  end
end
