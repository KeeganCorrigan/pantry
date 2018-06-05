class Pantry
  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(food)
    return 0 if @stock[food].nil?
    @stock[food]
  end

  def restock(food, quantity)
    @stock[food] += quantity if @stock.include?(food)
    @stock[food] = quantity if !@stock.include?(food)
  end
end
