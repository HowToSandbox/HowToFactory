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
