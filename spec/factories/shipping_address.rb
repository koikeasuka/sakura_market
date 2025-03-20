FactoryBot.define do
  factory :shipping_address do
    last_name { '山田' }
    first_name { '太郎' }
    tel { '09012345678' }
    post_code { '123-4567' }
    prefecture_id { 1 }
    city { '千代田区' }
    other_address { '霞ヶ関1丁目' }
    user
  end
end
