require 'rake/clean'
require 'rubygems'
require 'rubygems/package_task'
require 'rdoc/task'
Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
  rd.title = 'Your application title'
end

spec = Gem::Specification.load("todo.gemspec")

Gem::PackageTask.new(spec) do |pkg|
end
require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
end

task default: %w[setup]

desc "Create a file for your todos and set it to an empty list"
task :setup do
  file_name = 'todo.json'
  sh "touch #{file_name}"
  sh "echo '[]' > #{file_name}"
  puts "File '#{file_name}' empty todo list has been created"
end