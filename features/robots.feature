Feature: Middleman-Robots

  Scenario: Basic Usage
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      configure :build do
        activate :robots
      end
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then a file named "robots.txt" should exist
    And the output should contain "middleman-robots: robots.txt created"

  Scenario: Rules option with user-agent
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      configure :build do
        activate :robots, :rules => [
          {'user-agent' => '*'}
        ]
      end
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "robots.txt" should contain exactly:
      """
      user-agent: *

      """

  Scenario: Rules option with Disallow
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      configure :build do
        activate :robots, :rules => [
          {
            'user-agent' => '*',
            :disallow =>  %w(tmp/* /something/dir/file_disallow.html)
          }
        ]
      end
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "robots.txt" should contain exactly:
      """
      user-agent: *
      Disallow: /tmp/*
      Disallow: /something/dir/file_disallow.html

      """

  Scenario: Rules option with Allow
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      configure :build do
        activate :robots, :rules => [
          {
            'user-agent' => '*',
            :allow =>  %w(allow/* /something/dir/file_allow.html)
          }
        ]
      end
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "robots.txt" should contain exactly:
      """
      user-agent: *
      Allow: /allow/*
      Allow: /something/dir/file_allow.html

      """

  Scenario: All Rules option
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      configure :build do
        activate :robots, :rules => [
          {
            'user-agent' => '*',
            :disallow =>  %w(tmp/* /something/dir/file_disallow.html),
            :allow =>  %w(allow/* /something/dir/file_allow.html)
          }
        ]
      end
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "robots.txt" should contain exactly:
      """
      user-agent: *
      Disallow: /tmp/*
      Disallow: /something/dir/file_disallow.html
      Allow: /allow/*
      Allow: /something/dir/file_allow.html

      """

  Scenario: Multiple Rules option
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      configure :build do
        activate :robots, :rules => [
          {
            'user-agent' => 'Googlebot',
            :disallow =>  %w(tmp/* /something/dir/file_disallow.html),
            :allow =>  %w(allow/* /something/dir/file_allow.html)
          },
          {
            'user-agent' => 'Googlebot-Image',
            :disallow =>  %w(tmp/* /something/dir/file_disallow.html),
            :allow =>  %w(allow/* /something/dir/file_allow.html)
          }
        ]
      end
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "robots.txt" should contain exactly:
      """
      user-agent: Googlebot
      Disallow: /tmp/*
      Disallow: /something/dir/file_disallow.html
      Allow: /allow/*
      Allow: /something/dir/file_allow.html

      user-agent: Googlebot-Image
      Disallow: /tmp/*
      Disallow: /something/dir/file_disallow.html
      Allow: /allow/*
      Allow: /something/dir/file_allow.html

      """

  Scenario: Sitemap option
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      configure :build do
        activate :robots, :sitemap => "http://example.com/sitemap.xml"
      end
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
      configure :build do
        activate :robots,
          :rules => [
            {
              'user-agent' => 'Googlebot',
              :disallow =>  %w(tmp/* /something/dir/file_disallow.html),
              :allow =>  %w(allow/* /something/dir/file_allow.html)
            },
            {
              'user-agent' => 'Googlebot-Image',
              :disallow =>  %w(tmp/* /something/dir/file_disallow.html),
              :allow =>  %w(allow/* /something/dir/file_allow.html)
            }
          ],
          :sitemap => "http://example.com/sitemap.xml"
      end
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "robots.txt" should contain exactly:
      """
      user-agent: Googlebot
      Disallow: /tmp/*
      Disallow: /something/dir/file_disallow.html
      Allow: /allow/*
      Allow: /something/dir/file_allow.html

      user-agent: Googlebot-Image
      Disallow: /tmp/*
      Disallow: /something/dir/file_disallow.html
      Allow: /allow/*
      Allow: /something/dir/file_allow.html

      Sitemap: http://example.com/sitemap.xml

      """

