require_relative "drink"
require_relative "ingredient"

class DrinkMaker
  attr_accessor :inventory

  def initialize(inventory)
    @inventory = inventory
  end

  def price(drink)
    drink.ingredients.map do |name, quantity|
      inventory[name].price * quantity
    end.inject(:+)
  end

  def available(drink)
    drink.ingredients.all? do |name, quantity|
      inventory[name].quantity >= quantity
    end
  end

  def dispense(drink)
    return false unless available(drink)
    drink.ingredients.each do |name, quantity|
      inventory[name].quantity -= quantity
    end
    true
  end
end
