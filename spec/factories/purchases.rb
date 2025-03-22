FactoryBot.define do
  factory :purchase do
    user
    shipping_fee { 600 }
    cash_on_delivery_fee { 300 }
    tax { 100 }
  end
end
