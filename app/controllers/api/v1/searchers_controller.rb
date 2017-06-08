class Api::V1::SearchersController < ApplicationController

	skip_before_filter :verify_authenticity_token

	def create
		bfile = Base64.decode64(params[:file])
		file_path = Rails.root.join("yangziliang.jpg")
		file = File.new(file_path, 'wb+')
		file << bfile
		file.close

		render json: Product.limit(10).to_json
	end

end
