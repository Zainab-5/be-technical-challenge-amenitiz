class Checkout
  def initialize(rules)
    @rules = rules
    @items = []
  end

  def scan(product)
    @items << product.dup
  end

  def total
    @rules.each { |rule| rule.apply(@items) }
    @items.sum(&:price).round(2)
  end

  def cart_items
    @items
  end

  def remove(code)
    index = @items.find_index { |item| item.code == code }
    if index
      @items.delete_at(index)
      true
    else
      false
    end
  end
end
