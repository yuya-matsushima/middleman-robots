require 'middleman-robots/generators/sitemap_uri'

RSpec.describe Middleman::Robots::Generators::SitemapUri do
  describe '#text' do
    subject do
      klass = described_class.new(uri)
      klass.text
    end

    context 'with uri ' do
      let(:uri) { 'https://example.com/sitemap.xml' }

      it { is_expected.to eq "Sitemap: #{uri}" }
    end

    context 'without uri' do
      let(:uri) { nil }

      it { is_expected.to be_nil }
    end
  end
end
