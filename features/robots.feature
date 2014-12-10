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

