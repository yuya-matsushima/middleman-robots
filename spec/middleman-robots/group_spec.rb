require_relative '../../lib/middleman-robots/group.rb'

RSpec.describe Middleman::Robots::Group do
  let(:rules) do
    {
      user_agent: 'GoogleBot',
      disallow: %w[tmp/* /someting/dir/disallow.html],
      allow: %w[allow/* /someting/dir/allow.html]
    }
  end

  describe '#initialize' do
    subject { Middleman::Robots::Group.new(rules) }

    context 'with all options' do
      it { expect(subject.user_agent).to eq rules[:user_agent] }
      it { expect(subject.disallow).to eq(rules[:disallow].map { |path| File.join('/', path) }) }
      it { expect(subject.allow).to eq(rules[:allow].map { |path| File.join('/', path) }) }
    end

    context 'with allow and disallow' do
      let(:rules) do
        {
          disallow: %w[/tmp/*],
          allow: %w[/allow/*]
        }
      end

      it { expect(subject.user_agent).to eq '*' }
      it { expect(subject.disallow).to eq rules[:disallow] }
      it { expect(subject.allow).to eq rules[:allow] }
    end

    context 'with user_agent and allow' do
      let(:rules) do
        {
          user_agent: 'GoogleBot',
          allow: %w[/allow/* /someting/dir/allow.html]
        }
      end

      it { expect(subject.user_agent).to eq rules[:user_agent] }
      it { expect(subject.disallow).to be_empty }
      it { expect(subject.allow).to eq rules[:allow] }
    end

    context 'with user_agent and disallow' do
      let(:rules) do
        {
          user_agent: 'GoogleBot',
          disallow: %w[/tmp/* /someting/dir/disallow.html]
        }
      end

      it { expect(subject.user_agent).to eq rules[:user_agent] }
      it { expect(subject.disallow).to eq rules[:disallow] }
      it { expect(subject.allow).to be_empty }
    end
  end

  describe '#text' do
    subject do
      klass = Middleman::Robots::Group.new(rules)
      klass.text
    end

    context 'with all options' do
      let(:expected) do
        <<~ROBOTS
          User-Agent: GoogleBot
          Disallow: /tmp/*
          Disallow: /someting/dir/disallow.html
          Allow: /allow/*
          Allow: /someting/dir/allow.html
        ROBOTS
      end

      it { is_expected.to eq expected }
    end

    context 'with disallow and allow' do
      let(:rules) do
        {
          disallow: %w[/tmp/*],
          allow: %w[/allow/*]
        }
      end
      let(:expected) do
        <<~ROBOTS
          User-Agent: *
          Disallow: /tmp/*
          Allow: /allow/*
        ROBOTS
      end

      it { is_expected.to eq expected }
    end

    context 'with user_agent and allow' do
      let(:rules) do
        {
          user_agent: 'GoogleBot',
          allow: %w[/allow/* /someting/dir/allow.html]
        }
      end
      let(:expected) do
        <<~ROBOTS
          User-Agent: GoogleBot
          Allow: /allow/*
          Allow: /someting/dir/allow.html
        ROBOTS
      end

      it { is_expected.to eq expected }
    end

    context 'with user_agent and disallow' do
      let(:rules) do
        {
          user_agent: 'GoogleBot',
          disallow: %w[/tmp/* /someting/dir/disallow.html]
        }
      end
      let(:expected) do
        <<~ROBOTS
          User-Agent: GoogleBot
          Disallow: /tmp/*
          Disallow: /someting/dir/disallow.html
        ROBOTS
      end

      it { is_expected.to eq expected }
    end
  end
end
