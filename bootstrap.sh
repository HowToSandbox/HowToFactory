#! /bin/sh
#

echo "Building All The Things!"
mkdir ./support
mkdir ./spec
mkdir ./spec/prod
mkdir ./spec/test
mkdir ./spec/sandbox
touch ./Rakefile
touch ./Gemfile
touch ./require.rb
touch ./support/common.rb
touch ./support/config.rb
touch ./support/secrets.rb

echo "Writing Sample Code!"
cat <<EOM > ./Rakefile
require 'rake/testtask'
require 'rspec'
require 'rspec/core/rake_task'

# To invoke rake task     
# rake namespace:test_all                           runs all files in the folder associated with that namespace
# rake namespace:{fileName_leavingOff_rspec.rb}     runs a specific file in in the folder assiciated with that namespace

# Examples: 
# rake test:test_all    runs all files in spec/test
# rake test:mytestfile  runs spec/test/mytestfile_rspec.rb
# rake dev:mytestfile   runs spec/dev/mytestfile_rspec.rb

namespace :prod do
  RSpec::Core::RakeTask.new(:run_all) do |t|
    t.verbose = true
    t.pattern = FileList['spec/prod/*_rspec.rb'] 
  end
  #Special constructor rule for the sandbox
  rule(/prod:.+/) do |t|
  name = t.name.gsub("prod:","")
  path = File.join( File.dirname(__FILE__),'spec/prod','%s_rspec.rb'%name )
      if File.exist? path
        RSpec::Core::RakeTask.new(name) do |t|
      t.verbose = true
          t.pattern = FileList[path]  
        end
      puts "\nRunning spec/%s_rspec.rb"%[name]
      Rake::Task[name].invoke
      else
        puts "File does not exist: %s"%path
      end
  end
end

namespace :test do 
  RSpec::Core::RakeTask.new(:run_all) do |t|
    t.verbose = true
    t.pattern = FileList['spec/test/*_rspec.rb']
  end
  #Special constructor rule test
  rule(/test:.+/) do |t|
  name = t.name.gsub("test:","")
  path = File.join( File.dirname(__FILE__),'spec/test','%s_rspec.rb'%name )
      if File.exist? path
        RSpec::Core::RakeTask.new(name) do |t|
      t.verbose = true
          t.pattern = FileList[path]  
        end
      puts "\nRunning spec/%s_rspec.rb"%[name]
      Rake::Task[name].invoke
      else
        puts "File does not exist: %s"%path
      end
  end
end



namespace :dev do 
    RSpec::Core::RakeTask.new(:run_all) do |t| #because sometimes people forget things
      t.verbose = true
      t.pattern = FileList['spec/dev/*_rspec.rb']
    end


  #Special constructor rule for dev
  rule(/dev:.+/) do |t|
  name = t.name.gsub("dev:","")
  path = File.join( File.dirname(__FILE__),'spec/dev','%s_rspec.rb'%name )
      if File.exist? path
        RSpec::Core::RakeTask.new(name) do |t|
      t.verbose = true
          t.pattern = FileList[path]  
        end
      puts "\nRunning spec/%s_rspec.rb"%[name]
      Rake::Task[name].invoke
      else
        puts "File does not exist: %s"%path
      end
  end
end 

namespace :sandbox do
  RSpec::Core::RakeTask.new(:run_all) do |t|
    t.verbose = true
    t.pattern = FileList['spec/sandbox/*_rspec.rb'] 
  end
  #Special constructor rule for the sandbox
  rule(/sandbox:.+/) do |t|
  name = t.name.gsub("sandbox:","")
  path = File.join( File.dirname(__FILE__),'spec/sandbox','%s_rspec.rb'%name )
      if File.exist? path
        RSpec::Core::RakeTask.new(name) do |t|
      t.verbose = true
          t.pattern = FileList[path]  
        end
      puts "\nRunning spec/%s_rspec.rb"%[name]
      Rake::Task[name].invoke
      else
        puts "File does not exist: %s"%path
      end
  end
end

namespace :whirlygig do 
    RSpec::Core::RakeTask.new(:whirlygig) do |t|
      t.verbose = true
      t.pattern = FileList['spec/sandbox/whirlygig_rspec.rb'] 
    end
end
EOM

cat <<EOM >./support/common.rb


def grep
	grep = ENV["GREP"] || "default_string"
end


# this monkey patches the Ruby Integer class. Here, have a bananna!
class Integer
  def to_filesize
    {
      'B'  => 1024,
      'KB' => 1024 * 1024,
      'MB' => 1024 * 1024 * 1024,
      'GB' => 1024 * 1024 * 1024 * 1024,
      'TB' => 1024 * 1024 * 1024 * 1024 * 1024
    }.each_pair { |e, s| return "#{(self.to_f / (s / 1024)).round(2)}#{e}" if self < s }
  end
end


 
def valid_json? json_  
  JSON.parse(json_)
  puts "Valid JSON"  
  return true    
rescue JSON::ParserError 
  puts "Invalid JSON" 
  return false  
end

module FindByKey
  def find_by_key(object, key, out) #value_array= find_by_key(json, @key, [])
    object.each do |dict|
      out.push(dict[key])
      end
      return out
    end 
end

def parse_csv
    @file = 'path_to_csv'
      @testData = []
      File.open(@file, "r") do |f|
          f.each_line do |line|
          value = line.split(",")
          output = {:key_name0 => value[0],  
                    :key_name1 => value[1],
                    :key_name2 => value[2],
                    :key_name3 => value[3], 
                    :key_name4 => value[4]}
          @testData << output
          end
      end    
      @testData
end
EOM

cat <<EOM >./support/secrets.rb
# Usage:
#include NameCamelCase
#thing  = NameCamelCase::CONSTANT_NAME
#key 			= thing["key"]
#secret 	= thing["secret"]


module NameCamelCase
	CONSTANT_NAME   = {"key" => 'value', "secret" => 'value'}
	CONSTANT_NAME2  = {"key" => 'value', "secret" => 'value'}
end
EOM

cat <<EOM >./require.rb
require 'rubygems'
require 'rake'
require 'rspec'
require 'json'
require 'airborne'
require 'json_expressions'
require 'rest-client'
require "net/http"
require 'nokogiri'
require 'httparty'
require_relative 'support/urlConstructor'
require_relative 'support/config'
require_relative 'support/common'
#include ModuleName
EOM

cat <<EOM > ./Gemfile
source 'https://rubygems.org'
  
  gem 'rake'
  gem 'rspec'
  gem 'json'
  gem 'airborne'
  gem 'json_expressions'
  gem 'rest-client'
  gem 'nokogiri'
  gem 'httparty'
EOM
cat <<EOM >./spec/sample_file.rb
require_relative '../require.rb'
<your code Here>
EOM

cat <<EOM >./spec/sandbox/sample_file.rb
require_relative '../../require.rb'
<your code Here>
EOM

echo "Done!"