class Api::V1::ProductsController < ApplicationController

	def index
		render json: Product.limit(10).to_json
	end

end
