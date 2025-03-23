class DeliveryTimeSlot < ActiveHash::Base
  include ActiveHash::Associations
  has_many :shipping, dependent: :restrict_with_exception

  self.data = [
    { id: 1, name: '8-12' },
    { id: 2, name: '12-14' },
    { id: 3, name: '14-16' },
    { id: 4, name: '16-18' },
    { id: 5, name: '18-20' },
    { id: 6, name: '20-21' },
  ]
end
