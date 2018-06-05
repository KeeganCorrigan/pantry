require 'pry'

class Pantry
  attr_reader :stock,
              :shopping_list

  def initialize
    @stock = {}
    @shopping_list = {}
  end

  def stock_check(food)
    return 0 if @stock[food].nil?
    @stock[food]
  end

  def restock(food, quantity)
    @stock[food] += quantity if @stock.include?(food)
    @stock[food] = quantity if !@stock.include?(food)
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.each do |food, quantity|
      @shopping_list[food] += quantity if @shopping_list.include?(food)
      @shopping_list[food] = quantity if !@shopping_list.include?(food)
    end
  end

  def print_shopping_list
    @shopping_list.inject('') do |list, (food, quantity)|
        list << "* #{food}:" + " #{quantity}\n"
    end.chomp
  end
end
