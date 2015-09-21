require_relative '../../require.rb'

this_file = File.expand_path(__FILE__)
puts "-------------------------------------------------------------------------------\n"
puts "\n***** Running #{this_file} ******\n"

describe 'Factory - ' do 
	before(:all) do
	end
	it 'Example Factory' do
		factory = FactoryHelper.new #create a new instance of the FactoryHelper class in ../../support/common.rb
		mything = factory.thing("bananna", "fruit", "sweet") #create a thing using the thing method in the FactoryHelper class
		puts mything
	end
	
end