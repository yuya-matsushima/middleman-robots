# frozen_string_literal: true

require 'bundler/gem_tasks'

task default: :test

desc 'test command'
task :test do
  sh 'bundle exec rspec spec/'
  sh 'bundle exec cucumber features/'
end
