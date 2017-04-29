require 'bundler/gem_tasks'

task default: :test

desc 'test command'
task :test do
  Dir.glob('tests/test_*.rb') do |f|
    sh "bundle exec ruby #{f}"
  end
  sh 'bundle exec cucumber features/'
end
