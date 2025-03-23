FactoryBot.define do
  factory :purchase_item do
    purchase
    item
    price { 350 }
  end
end
