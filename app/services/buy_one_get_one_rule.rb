class BuyOneGetOneRule
  def initialize(code)
    @code = code
  end

  def apply(items)
    selected_items = items.select { |item| item.code == @code }

    selected_items.first(selected_items.count / 2).each { |i| i.price = 0 }
  end
end
