require 'json'

namespace :load_json do
  
  desc "load items form json"
  task :run => :environment do
  	json = File.open("/Users/yangyi/Downloads/output.json", 'r').read
  	obj = JSON.parse(json)
  	Product.create obj
  end

  desc "fetch image from internet" do
  	task :fetch_images => :environment do
  		Product.all.each do |product|
  			product.fetch_images
  		end
  	end
  end

end