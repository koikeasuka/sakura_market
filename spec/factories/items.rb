FactoryBot.define do
  factory :item do
    name { 'いちご' }
    description { '新鮮ないちごです' }
    price { 1000 }
    is_published { true }
  end
end
