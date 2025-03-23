class CashOnDeliveryFee < ActiveHash::Base
  self.data = [
    {
      id: 1,
      min_price: 0,
      max_price: 9999,
      fee: 300,
    },
    {
      id: 2,
      min_price: 10000,
      max_price: 30000,
      fee: 400,
    },
    {
      id: 3,
      min_price: 29999,
      max_price: 100000,
      fee: 600,
    },
    {
      id: 4,
      min_price: 299999,
      max_price: nil,
      fee: 1000,
    },
  ]

  def self.extract_fee(amount_price)
    find { |record| amount_price >= record.min_price && (record.max_price.nil? || amount_price < record.max_price) }
  end
end
