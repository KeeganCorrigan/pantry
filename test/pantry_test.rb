require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/recipe'

class PantryTest < Minitest::Test
  def test_it_exists
    pantry = Pantry.new
    assert_instance_of(Pantry, pantry)
  end

  def test_stock_is_empty_hash
    pantry = Pantry.new
    assert_equal Hash, pantry.stock.class
    assert_equal 0, pantry.stock.length
  end

  def test_it_checks_stock
    pantry = Pantry.new
    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_it_restocks_and_increments
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    assert_equal 10, pantry.stock_check("Cheese")
    pantry.restock("Cheese", 20)
    assert_equal 30, pantry.stock_check("Cheese")
  end

  def test_it_adds_the_recipe_to_shopping_list
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r)
    expected = { "Cheese" => 20, "Flour" => 20 }
    assert_equal expected, pantry.shopping_list
  end

  def test_you_can_add_two_recipes
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r)
    r = Recipe.new("Spaghetti")
    r.add_ingredient("Spaghetti Noodles", 10)
    r.add_ingredient("Marinara Sauce", 10)
    r.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r)
    expected = { "Cheese" => 25, "Flour" => 20, "Spaghetti Noodles" => 10, "Marinara Sauce" => 10 }
    assert_equal expected, pantry.shopping_list
  end

  def test_it_can_print_the_shopping_list
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r)
    r = Recipe.new("Spaghetti")
    r.add_ingredient("Spaghetti Noodles", 10)
    r.add_ingredient("Marinara Sauce", 10)
    r.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r)
    expected = "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
    assert_equal expected, pantry.print_shopping_list
  end
end
