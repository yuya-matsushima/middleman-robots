require "bundler/gem_tasks"

task default: :test

desc 'test command'
task :test do
  sh 'bundle exec ruby tests/*'
  sh 'bundle exec cucumber features/'
end
