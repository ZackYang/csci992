class Product < ActiveRecord::Base

	before_validation :remove_html_tag

	after_create :fetch_images

	has_many :images

	def remove_html_tag
		self.description = ActionView::Base.full_sanitizer.sanitize self.description.gsub(/[\"\\n\\t\n\t]+/,'')
		self.title = ActionView::Base.full_sanitizer.sanitize self.title.gsub(/[\"\\n\\t\n\t]+/,'')
	end

	def fetch_images
		return if self.has_images
		img_url = self.image_urls.strip.match(/http.+$/).to_s
		self.images.create(url: img_url)
	end
	

	class << self

		def remove_html_tag
			all.each do |p|
				p.description = ActionView::Base.full_sanitizer.sanitize p.description.gsub(/[\"\\n\\t\n]+/,'')
				p.title = ActionView::Base.full_sanitizer.sanitize p.title.gsub(/[\"\\n\\t\n\t]+/,'')
				p.save
			end
		end

	end

end
