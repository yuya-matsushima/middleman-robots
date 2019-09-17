require 'middleman-robots/generators/sitemap_uri'

RSpec.describe Middleman::Robots::Generators::SitemapUri do
  describe '#text' do
    subject { described_class.new(uri).text }

    context 'with uri value is' do
      context 'URL String' do
        let(:uri) { 'https://example.com/sitemap.xml' }

        it { is_expected.to eq "Sitemap: #{uri}" }
      end

      context 'nil' do
        let(:uri) { nil }

        it { is_expected.to be_nil }
      end

      context 'empty' do
        let(:uri) { '' }

        it { is_expected.to be_nil }
      end

      context 'ERROR when' do
        subject { -> { described_class.new(rule).text } }

        context 'Array' do
          let(:rule) { { uri: %w[a b] } }

          it { is_expected.to raise_error ArgumentError }
        end

        context 'Numeric' do
          let(:rule) { { uri: 1_000 } }

          it { is_expected.to raise_error ArgumentError }
        end

        context 'Symbol' do
          let(:rule) { { uri: :uri } }

          it { is_expected.to raise_error ArgumentError }
        end
      end
    end
  end
end
