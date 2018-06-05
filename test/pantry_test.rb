require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/recipe'
require 'pry'

class PantryTest < Minitest::Test
  def setup
    recipe_1 = Recipe.new("Cheese Pizza")
    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)
    recipe_2 = Recipe.new("Pickles")
    recipe_2.add_ingredient("Brine", 10)
    recipe_2.add_ingredient("Cucumbers", 30)
    recipe_3 = Recipe.new("Peanuts")
    recipe_3.add_ingredient("Raw nuts", 10)
    recipe_3.add_ingredient("Salt", 10)
    @pantry = Pantry.new
    @pantry.add_to_cookbook(recipe_1)
    @pantry.add_to_cookbook(recipe_2)
    @pantry.add_to_cookbook(recipe_3)
    @pantry.restock("Cheese", 10)
    @pantry.restock("Flour", 20)
    @pantry.restock("Brine", 40)
    @pantry.restock("Cucumbers", 120)
    @pantry.restock("Raw nuts", 20)
    @pantry.restock("Salt", 20)
  end

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

  def test_shopping_list_empty
    pantry = Pantry.new
    assert_equal Hash, pantry.shopping_list.class
    assert_equal 0, pantry.shopping_list.length
  end

  def test_it_adds_the_recipe_to_shopping_list
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry = Pantry.new
    pantry.add_to_shopping_list(r)
    expected = { "Cheese" => 20, "Flour" => 20 }
    assert_equal expected, pantry.shopping_list
  end

  def test_you_can_add_two_recipes
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry = Pantry.new
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
    pantry = Pantry.new
    pantry.add_to_shopping_list(r)
    r = Recipe.new("Spaghetti")
    r.add_ingredient("Spaghetti Noodles", 10)
    r.add_ingredient("Marinara Sauce", 10)
    r.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r)
    expected = "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
    assert_equal expected, pantry.print_shopping_list
  end

  def test_cookbook_exists
    pantry = Pantry.new
    assert_equal Hash, pantry.cookbook.class
    assert_equal 0, pantry.cookbook.length
  end

  def test_it_can_add_to_cookbook
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    pantry = Pantry.new
    pantry.add_to_cookbook(r1)
    expected = { "Cheese Pizza"=> {"Cheese"=> 20, "Flour"=> 20} }
    assert_equal expected, pantry.cookbook
  end

  def test_what_can_i_make
    expected = ["Pickles", "Peanuts"]
    assert_equal expected, @pantry.what_can_i_make
  end

  def test_how_many_can_i_make
    expected = {"Pickles" => 4, "Peanuts" => 2}
    assert_equal expected, @pantry.how_many_can_i_make
  end
end
