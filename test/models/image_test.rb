require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @product = products(:one)
    @url = 'http://www.kmart.com.au/wcsstore/Kmart/images/ncatalog/tf/6/42436126-1-tf.jpg'
  end

  test "Create filename" do
  	image = @product.images.build url: @url
  	image.create_filename
  	assert_equal @product.id.to_s.rjust(20, '0') + '00', image.filename
  end

  test "Fetch File From url" do
  	image = @product.images.build url: @url
  	image.create_filename
  	image.fetch_image
  end
end
