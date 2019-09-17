require 'middleman-robots/group'

RSpec.describe Middleman::Robots::Group do
  let(:rule) do
    {
      user_agent: 'GoogleBot',
      disallow: %w[tmp/* /someting/dir/disallow.html],
      allow: %w[allow/* /someting/dir/allow.html]
    }
  end

  describe '#text' do
    subject do
      klass = Middleman::Robots::Group.new(rule)
      klass.text
    end

    context 'with all options' do
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

      it { is_expected.to eq expected.chomp }
    end

    context 'with disallow and allow' do
      let(:rule) do
        {
          disallow: %w[/tmp/*],
          allow: %w[/allow/*]
        }
      end
      let(:expected) do
        expected =<<~ROBOTS
          User-Agent: *
          Disallow: /tmp/*
          Allow: /allow/*
        ROBOTS
        expected.chomp
      end

      it { is_expected.to eq expected }
    end

    context 'with user_agent and allow' do
      let(:rule) do
        {
          user_agent: 'GoogleBot',
          allow: %w[/allow/* /someting/dir/allow.html]
        }
      end
      let(:expected) do
        expected =<<~ROBOTS
          User-Agent: GoogleBot
          Allow: /allow/*
          Allow: /someting/dir/allow.html
        ROBOTS
        expected.chomp
      end

      it { is_expected.to eq expected }
    end

    context 'with user_agent and disallow' do
      let(:rule) do
        {
          user_agent: 'GoogleBot',
          disallow: %w[/tmp/* /someting/dir/disallow.html]
        }
      end
      let(:expected) do
        expected =<<~ROBOTS
          User-Agent: GoogleBot
          Disallow: /tmp/*
          Disallow: /someting/dir/disallow.html
        ROBOTS
        expected.chomp
      end

      it { is_expected.to eq expected }
    end
  end
end
