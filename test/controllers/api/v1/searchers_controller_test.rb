require 'test_helper'

class Api::V1::SearchersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "create a searcher" do
  	test_image = Rails.root.join('public', 'test.jpg').to_s
  	file = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
  	post :create, file: file
  	puts @response.body
  	assert_response :success
  end

end
