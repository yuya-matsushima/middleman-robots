Feature: Middleman-Robots on server

  Scenario: All options
    Given the Server is running at "server-app"
    When I go to "/robots.txt"
    Then I should see:
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

