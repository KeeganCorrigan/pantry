require 'pry'

class Pantry
  attr_reader :stock,
              :shopping_list,
              :cookbook

  def initialize
    @stock = {}
    @shopping_list = {}
    @cookbook = {}
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

  def add_to_cookbook(recipe)
    @cookbook[recipe.name] = recipe.ingredients
  end

  def what_can_i_make
    @cookbook.each_with_object([]) do |(food, ingredients), collector|
      if (ingredients.keys - @stock.keys).empty?
        binding.pry
        ingredients.each do |ingredient, quantity|
          collector << food if quantity < @stock[ingredient]
        end
      end
      collector
    end
  end
end
