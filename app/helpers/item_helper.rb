module ItemHelper
  def product_photo_image(item)
    item.product_photo.attached? ? item.product_photo.variant(:image) : 'no_image.jpg'
  end
end
