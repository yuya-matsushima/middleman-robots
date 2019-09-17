require 'middleman-robots/generator'

RSpec.describe Middleman::Robots::Generator do
  describe '#process' do
    subject { Middleman::Robots::Generator.new(rules, sitemap_uri).process }

    context 'with all options' do
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
      let(:sitemap_uri) { 'http://example.com/sitemap.xml' }
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

      it { is_expected.to eq expected }
    end

    context 'without options' do
      let(:rules) { nil }
      let(:sitemap_uri) { nil }

      it { is_expected.to be_empty }
    end
  end
end
