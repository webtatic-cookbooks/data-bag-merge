#!/usr/bin/env rake

# Don't output shell commands for fileutils
Rake::FileUtilsExt.verbose(false)

desc "Runs foodcritic linter"
task :foodcritic do
  if Gem::Version.new("1.9.2") <= Gem::Version.new(RUBY_VERSION.dup)
    prepare_foodcritic_sandbox(sandbox_path)

    sh "bundle exec foodcritic --epic-fail ~FC015 #{File.dirname(sandbox_path)}"
  else
    puts "WARN: foodcritic run is skipped as Ruby #{RUBY_VERSION} is < 1.9.2."
  end
end

task :lint do
  prepare_foodcritic_sandbox(sandbox_path)

  sh "bundle exec knife cookbook test #{cookbook_name} -o #{sandbox_path}/../ --config #{File.dirname(__FILE__)}/test/lint/knife.rb"
end

task :test => ['lint', 'foodcritic']

private

def cookbook_name
  File.basename(File.dirname(__FILE__))
end

def sandbox_path
  File.join(File.dirname(__FILE__), %W(tmp cookbooks #{cookbook_name}))
end

def prepare_foodcritic_sandbox(sandbox)
  files = %w{*.md *.rb attributes definitions files libraries providers
recipes resources templates}

  rm_rf sandbox
  mkdir_p sandbox
  cp_r Dir.glob("{#{files.join(',')}}"), sandbox
  puts "\n\n"
end