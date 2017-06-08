require 'open-uri'

class Api::V1::ProductsController < ApplicationController

	def index
		list = nil
		open("http://localhost:8081?filename=#{params[:filename]}") do |response|
			list = JSON.parse(response.read)
		end
		list.map! do |item|
			item.gsub(/\//, '').to_i
		end
		@images = Image.where("id IN (?)", list)
	end

	def create
		render json: {}.to_json
	end

end
