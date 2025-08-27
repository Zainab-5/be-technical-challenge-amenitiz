require 'rails_helper'

RSpec.describe Checkout do
  let(:gr1) { Product.create!(code: "GR1", name: "Green Tea", price: 3.11) }
  let(:sr1) { Product.create!(code: "SR1", name: "Strawberries", price: 5.00) }
  let(:cf1) { Product.create!(code: "CF1", name: "Coffee", price: 11.23) }

  it "calculates total with rules" do
    rules = [
      BuyOneGetOneRule.new("GR1"),
      BulkPriceRule.new("SR1", 3, 4.50),
      BulkPriceRule.new("CF1", 3, (11.23 * 2/3.0).round(2))
    ]
    co = Checkout.new(rules)

    [ gr1, cf1, sr1, cf1, cf1 ].each { |p| co.scan(p) }
    expect(co.total.to_f).to eq(30.58)
  end
end
