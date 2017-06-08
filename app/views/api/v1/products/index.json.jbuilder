json.array! @images do |image|
  json.image image_url('/products/' + image.file_url)
end