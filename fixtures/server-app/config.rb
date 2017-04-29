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
