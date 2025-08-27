class BulkPriceRule
  def initialize(code, min_qty, new_price)
    @code, @min_qty, @new_price = code, min_qty, new_price
  end

  def apply(items)
    prod = items.select { |i| i.code == @code }
    return unless prod.count >= @min_qty
    prod.each { |i| i.price = @new_price }
  end
end
