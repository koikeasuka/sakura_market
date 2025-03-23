module ItemHelper
  def product_photo_image(item)
    item.product_photo.attached? ? item.product_photo.variant(:image) : 'no_image.jpg'
  end

  def product_photo_thumb(item)
    item.product_photo.attached? ? item.product_photo.variant(:thumb) : 'no_image.jpg'
  end
end
