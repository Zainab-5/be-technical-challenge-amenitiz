# app/controllers/checkout_controller.rb
class CheckoutsController < ApplicationController
  def new
    # This will look for app/views/checkout/new.html.erb
    @products = Product.all
  end

  def create
    # debugger
    # Fetch all products
    @products = Product.all

    # Scan items based on submitted quantities
    items = []
    params[:quantity]&.each do |code, qty|
      product = Product.find_by(code: code)
      qty.to_i.times { items << product } if product
    end

    # Define pricing rules
    rules = [
      BuyOneGetOneRule.new("GR1"),                     # Green Tea BOGO
      BulkPriceRule.new("SR1", 3, 4.50),              # Strawberries bulk
      BulkPriceRule.new("CF1", 3, (11.23 * 2 / 3.0))  # Coffee bulk
    ]

    # Calculate total
    co = Checkout.new(rules)
    items.each { |item| co.scan(item) }
    @total = co.total || 0

    puts "Total calculated: #{@total.inspect}"

    render :new
  end
end
