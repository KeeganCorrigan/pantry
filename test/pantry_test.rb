require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

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
end
