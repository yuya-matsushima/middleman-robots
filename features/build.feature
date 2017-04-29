Feature: Middleman-Robots

  Scenario: Empty Usage
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      activate :robots
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then a file named "robots.txt" should exist
    And the output should contain "== middleman-robots: robots.txt added to resources =="
    And the file "robots.txt" should contain exactly:
      """
      """

  Scenario: Rules option with user_agent
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      activate :robots, :rules => [
        {:user_agent => '*'}
      ]
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "robots.txt" should contain exactly:
      """
      User-Agent: *
      """

  Scenario: Rules option with user_agent using block
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      activate :robots do |r|
        r.rules = [
          {:user_agent => '*'}
        ]
      end
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "robots.txt" should contain exactly:
      """
      User-Agent: *
      """

  Scenario: Rules option with user_agent
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      activate :robots, :rules => [
        {:user_agent => '*'}
      ]
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "robots.txt" should contain exactly:
      """
      User-Agent: *
      """

  Scenario: Rules option with user-agent
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      activate :robots, :rules => [
        {'user-agent' => '*'}
      ]
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "robots.txt" should contain exactly:
      """
      User-Agent: *
      """

  Scenario: Rules option with Disallow
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      activate :robots, :rules => [
        {
          :user_agent => '*',
          :disallow =>  %w(tmp/* /something/dir/file_disallow.html)
        }
      ]
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "robots.txt" should contain exactly:
      """
      User-Agent: *
      Disallow: /tmp/*
      Disallow: /something/dir/file_disallow.html
      """

  Scenario: Rules option with Allow
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      activate :robots, :rules => [
        {
          :user_agent => '*',
          :allow =>  %w(allow/* /something/dir/file_allow.html)
        }
      ]
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "robots.txt" should contain exactly:
      """
      User-Agent: *
      Allow: /allow/*
      Allow: /something/dir/file_allow.html
      """

  Scenario: All Rules
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      activate :robots, :rules => [
        {
          :user_agent => '*',
          :disallow =>  %w(tmp/* /something/dir/file_disallow.html),
          :allow =>  %w(allow/* /something/dir/file_allow.html)
        }
      ]
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "robots.txt" should contain exactly:
      """
      User-Agent: *
      Disallow: /tmp/*
      Disallow: /something/dir/file_disallow.html
      Allow: /allow/*
      Allow: /something/dir/file_allow.html
      """

  Scenario: Multiple Rules
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      activate :robots, :rules => [
        {
          :user_agent => 'Googlebot',
          :disallow =>  %w(tmp/* /something/dir/file_disallow.html),
          :allow =>  %w(allow/* /something/dir/file_allow.html)
        },
        {
          :user_agent => 'Googlebot-Image',
          :disallow =>  %w(tmp/* /something/dir/file_disallow.html),
          :allow =>  %w(allow/* /something/dir/file_allow.html)
        }
      ]
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "robots.txt" should contain exactly:
      """
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
      """

  Scenario: Sitemap option
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      activate :robots, :sitemap => "http://example.com/sitemap.xml"
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "robots.txt" should contain exactly:
      """
      Sitemap: http://example.com/sitemap.xml
      """

  Scenario: All options
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      activate :robots,
        :rules => [
          {
            :user_agent => 'Googlebot',
            :disallow =>  %w(tmp/* /something/dir/file_disallow.html),
            :allow =>  %w(allow/* /something/dir/file_allow.html)
          },
          {
            :user_agent => 'Googlebot-Image',
            :disallow =>  %w(tmp/* /something/dir/file_disallow.html),
            :allow =>  %w(allow/* /something/dir/file_allow.html)
          }
        ],
        :sitemap => "http://example.com/sitemap.xml"
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "robots.txt" should contain exactly:
      """
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
      """

