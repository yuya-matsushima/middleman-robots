require 'middleman-robots/generators/block'

RSpec.describe Middleman::Robots::Generators::Block do
  describe '#text' do
    subject { described_class.new(rule).text }

    context 'with all options' do
      let(:rule) do
        {
          user_agent: 'GoogleBot',
          disallow: %w[tmp/* /someting/dir/disallow.html],
          allow: %w[allow/* /someting/dir/allow.html]
        }
      end
      let(:expected) do
        expected =<<~ROBOTS
          User-Agent: GoogleBot
          Disallow: /tmp/*
          Disallow: /someting/dir/disallow.html
          Allow: /allow/*
          Allow: /someting/dir/allow.html
        ROBOTS
        expected.chomp
      end

      it { is_expected.to eq expected }
    end

    context 'without option' do
      let(:rule) { {} }

      it { is_expected.to eq 'User-Agent: *' }
    end

    context 'with user_agent value is' do
      context 'Middleman-Bot' do
        let(:rule) { { user_agent: 'Middleman-Bot' } }

        it { is_expected.to eq "User-Agent: #{rule[:user_agent]}" }
      end

      context 'nil' do
        let(:rule) { { user_agent: nil } }

        it { is_expected.to eq 'User-Agent: *' }
      end

      context 'empty' do
        let(:rule) { { user_agent: '' } }

        it { is_expected.to eq 'User-Agent: *' }
      end

      context 'ERROR when' do
        subject { -> { described_class.new(rule).text } }

        context 'Array' do
          let(:rule) { { user_agent: %w[a b] } }

          it { is_expected.to raise_error ArgumentError }
        end

        context 'Numeric' do
          let(:rule) { { user_agent: 1_000 } }

          it { is_expected.to raise_error ArgumentError }
        end

        context 'Symbol' do
          let(:rule) { { user_agent: :user_agent } }

          it { is_expected.to raise_error ArgumentError }
        end
      end
    end

    context 'with disallow value is' do
      context 'single Array' do
        let(:rule) { { disallow: %w[/tmp/*] } }
        let(:expected) do
          expected =<<~ROBOTS
            User-Agent: *
            Disallow: /tmp/*
          ROBOTS
          expected.chomp
        end

        it { is_expected.to eq expected }
      end

      context 'multiple Array' do
        let(:rule) { { disallow: %w[/tmp/* /something/disallow.html] } }
        let(:expected) do
          expected =<<~ROBOTS
            User-Agent: *
            Disallow: /tmp/*
            Disallow: /something/disallow.html
          ROBOTS
          expected.chomp
        end

        it { is_expected.to eq expected }
      end

      context 'nil' do
        let(:rule) { { disallow: nil } }

        it { is_expected.to eq 'User-Agent: *' }
      end

      context 'ERROR when' do
        subject { -> { described_class.new(rule).text } }

        context 'empty' do
          let(:rule) { { disallow: '' } }

          it { is_expected.to raise_error ArgumentError }
        end

        context 'String' do
          let(:rule) { { disallow: 'string' } }

          it { is_expected.to raise_error ArgumentError }
        end

        context 'Numeric' do
          let(:rule) { { disallow: 1_000 } }

          it { is_expected.to raise_error ArgumentError }
        end

        context 'Symbol' do
          let(:rule) { { disallow: :disallow } }

          it { is_expected.to raise_error ArgumentError }
        end
      end
    end

    context 'when allow value is' do
      context 'single Array' do
        let(:rule) { { allow: %w[/tmp/*] } }
        let(:expected) do
          expected =<<~ROBOTS
            User-Agent: *
            Allow: /tmp/*
          ROBOTS
          expected.chomp
        end

        it { is_expected.to eq expected }
      end

      context 'multiple Array' do
        let(:rule) { { allow: %w[/tmp/* /something/allow.html] } }
        let(:expected) do
          expected =<<~ROBOTS
            User-Agent: *
            Allow: /tmp/*
            Allow: /something/allow.html
          ROBOTS
          expected.chomp
        end

        it { is_expected.to eq expected }
      end

      context 'nil' do
        let(:rule) { { allow: nil } }

        it { is_expected.to eq 'User-Agent: *' }
      end

      context 'ERROR when' do
        subject { -> { described_class.new(rule).text } }

        context 'empty' do
          let(:rule) { { allow: '' } }

          it { is_expected.to raise_error ArgumentError }
        end

        context 'String' do
          let(:rule) { { allow: 'string' } }

          it { is_expected.to raise_error ArgumentError }
        end

        context 'Numeric' do
          let(:rule) { { allow: 1_000 } }

          it { is_expected.to raise_error ArgumentError }
        end

        context 'Symbol' do
          let(:rule) { { allow: :disallow } }

          it { is_expected.to raise_error ArgumentError }
        end
      end
    end
  end
end
