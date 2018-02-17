require 'minitest/autorun'
require_relative '../lib/middleman-robots/group.rb'

class TestGroup < MiniTest::Test
  def test_initialize
    rule = {
      user_agent: 'GoogleBot',
      disallow: %w[tmp/* /someting/dir/disallow.html],
      allow: %w[allow/* /someting/dir/allow.html]
    }
    group = Middleman::Robots::Group.new(rule)

    assert_equal rule[:user_agent], group.user_agent
    assert_equal %w[/tmp/* /someting/dir/disallow.html], group.disallow
    assert_equal %w[/allow/* /someting/dir/allow.html], group.allow
  end

  def test_initialize_without_user_agent
    rule = {
      disallow: %w[/tmp/*],
      allow: %w[/allow/*]
    }
    group = Middleman::Robots::Group.new(rule)

    assert_equal '*', group.user_agent
    assert_equal rule[:disallow], group.disallow
    assert_equal rule[:allow], group.allow
  end

  def test_initialize_without_disallow
    rule = {
      user_agent: 'GoogleBot',
      allow: %w[/allow/* /someting/dir/allow.html]
    }
    group = Middleman::Robots::Group.new(rule)

    assert_equal rule[:user_agent], group.user_agent
    assert_equal [], group.disallow
    assert_equal rule[:allow], group.allow
  end

  def test_initialize_without_allow
    rule = {
      user_agent: 'GoogleBot',
      disallow: %w[/tmp/* /someting/dir/disallow.html]
    }
    group = Middleman::Robots::Group.new(rule)

    assert_equal rule[:user_agent], group.user_agent
    assert_equal rule[:disallow], group.disallow
    assert_equal [], group.allow
  end

  def test_text
    rule = {
      user_agent: 'GoogleBot',
      disallow: %w[tmp/* /someting/dir/disallow.html],
      allow: %w[allow/* /someting/dir/allow.html]
    }
    group = Middleman::Robots::Group.new(rule)

    expected = <<~ROBOTS
      User-Agent: GoogleBot
      Disallow: /tmp/*
      Disallow: /someting/dir/disallow.html
      Allow: /allow/*
      Allow: /someting/dir/allow.html
    ROBOTS

    assert_equal expected, group.text
  end

  def test_text_without_user_agent
    rule = {
      disallow: %w[/tmp/*],
      allow: %w[/allow/*]
    }
    group = Middleman::Robots::Group.new(rule)

    expected = <<~ROBOTS
      User-Agent: *
      Disallow: /tmp/*
      Allow: /allow/*
    ROBOTS

    assert_equal expected, group.text
  end

  def test_text_without_disallow
    rule = {
      user_agent: 'GoogleBot',
      allow: %w[/allow/* /someting/dir/allow.html]
    }
    group = Middleman::Robots::Group.new(rule)

    expected = <<~ROBOTS
      User-Agent: GoogleBot
      Allow: /allow/*
      Allow: /someting/dir/allow.html
    ROBOTS

    assert_equal expected, group.text
  end

  def test_text_without_allow
    rule = {
      user_agent: 'GoogleBot',
      disallow: %w[/tmp/* /someting/dir/disallow.html]
    }
    group = Middleman::Robots::Group.new(rule)

    expected = <<~ROBOTS
      User-Agent: GoogleBot
      Disallow: /tmp/*
      Disallow: /someting/dir/disallow.html
    ROBOTS

    assert_equal expected, group.text
  end
end
