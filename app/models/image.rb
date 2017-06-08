require 'fileutils'
require 'open-uri'

class Image < ActiveRecord::Base

	validates :filename, :product, presence: true

	belongs_to :product

	before_validation :create_filename

	after_create :index_image, :fetch_image

	def create_filename
		file_index = self.product.images.count.to_s.rjust(2, '0')
		product_index = self.product_id.to_s.rjust(20, '0')
		self.filename = "#{product_index}#{file_index}"
	end

	def url= url
		@url = url
	end

	def fetch_image
		FileUtils.mkdir_p(File.dirname(file_path))
		puts file_path
		open(@url, "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36",
							"Cookie" => " visid_incap_382817=0EewsMxGQ/We8eOM5MiKA4TQNFkAAAAAQUIPAAAAAAD05LhJQ1JdZbqRkfLweN7M; incap_ses_137_382817=DOphD8BRxW5jggOP67nmAYTQNFkAAAAAC81rcVVuZaUbXULzuTCEvA=="
					) do |file|
   		File.open(file_path,"wb+") do |f|
    		f.puts file.read
    	end
   	end
   	self.product.update_attributes has_images: true
	end

	def file_path
		path = Rails.root.join('app/assets/images/products', self.filename.scan(/../).join("/") + '.jpg')
	end

	def file_url
		self.filename.scan(/../).join("/") + '.jpg'
	end

	def index_image
		Rails.application.config.redis_connect.lpush("queue", self.file_path + "\%\%"+ self.id.to_s)
	end

end
