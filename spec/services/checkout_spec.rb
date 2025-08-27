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




require 'rails_helper'

RSpec.describe Checkout, type: :model do
  let(:gr1) { Product.new(code: "GR1", name: "Green Tea", price: 3.11) }
  let(:sr1) { Product.new(code: "SR1", name: "Strawberries", price: 5.00) }
  let(:cf1) { Product.new(code: "CF1", name: "Coffee", price: 11.23) }

  let(:rules) { [ BuyOneGetOneRule.new("GR1"), BulkPriceRule.new("SR1", 3, 4.50) ] }
  let(:checkout) { Checkout.new(rules) }

  describe "#scan" do
    it "adds products to cart" do
      checkout.scan(gr1)
      expect(checkout.cart_items.count).to eq(1)
    end

    it "handles scanning multiple products" do
      checkout.scan(gr1)
      checkout.scan(sr1)
      expect(checkout.cart_items.size).to eq(2)
    end
  end

  describe "#total" do
    it "calculates total without discounts" do
      checkout.scan(sr1)
      checkout.scan(sr1)

      # strawbwerries are only 2, so no discount applied total is 10
      expect(checkout.total).to eq(10.00)
    end

    it "applies bulk discount correctly" do
      3.times { checkout.scan(sr1) }

      # discount applies as >=3
      expect(checkout.total).to eq(13.50) # 3 * 4.50
    end

    it "applies BOGO discount correctly" do
      2.times { checkout.scan(gr1) }

      # second GR1 free
      expect(checkout.total).to eq(3.11)
    end
  end

  describe "#remove" do
    it "removes a product if it exists" do
      checkout.scan(sr1)
      checkout.remove("SR1")
      expect(checkout.cart_items).to be_empty
    end

    it "returns false if product not found" do
      expect(checkout.remove("NON_EXIST")).to eq(false)
    end

    it "removes only the first matching product" do
      2.times { checkout.scan(sr1) }
      checkout.remove("SR1")
      expect(checkout.cart_items.size).to eq(1)
    end
  end

  describe "negative scenarios" do
    it "returns total as 0 when no products scanned" do
      expect(checkout.total).to eq(0)
    end

    it "does not break if discount rule doesn't apply" do
      checkout.scan(cf1)
      expect(checkout.total).to eq(11.23)
    end
  end
end
