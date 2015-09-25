require_relative "ingredient"
require_relative "drink"
require_relative "drink_maker"

class Baristomatic
  INITIAL_QUANTITY = 10

  def restok
    inventory.each { |_, item| item.quantity = INITIAL_QUANTITY }
  end

  def drink(drink_number)
    drinks[drink_number - 1]
  end

  def dispense(drink)
    drink_maker.dispense(drink) if drink
  end

  def inventory
    @inventory ||= {
      coffee: Ingredient.new("Coffee", INITIAL_QUANTITY, 0.75),
      decaf_coffee: Ingredient.new("Decaf Coffee", INITIAL_QUANTITY, 0.75),
      sugar: Ingredient.new("Sugar", INITIAL_QUANTITY, 0.25),
      cream: Ingredient.new("Cream", INITIAL_QUANTITY, 0.25),
      steamed_milk: Ingredient.new("Steamed Milk", INITIAL_QUANTITY, 0.35),
      foamed_milk: Ingredient.new("Foamed Milk", INITIAL_QUANTITY, 0.35),
      espresso: Ingredient.new("Espresso", INITIAL_QUANTITY, 1.10),
      cocoa: Ingredient.new("Cocoa", INITIAL_QUANTITY, 0.90),
      whipped_cream: Ingredient.new("Whipped Cream", INITIAL_QUANTITY, 1.00)
    }.sort.to_h
  end

  def drinks
    @drinks ||= [
      Drink.new("Coffee", coffee: 3, sugar: 1, cream: 1),
      Drink.new("Decaf Coffe", decaf_coffee: 3, sugar: 1, cream: 1),
      Drink.new("Caffe Latte", espresso: 2, steamed_milk: 1),
      Drink.new("Caffe Americano", espresso: 3),
      Drink.new("Caffe Mocha", espresso: 1, cocoa: 1, steamed_milk: 1, whipped_cream: 1),
      Drink.new("Cappuccino", espresso: 2, steamed_milk: 1, foamed_milk: 1)
    ].sort_by(&:name)
  end

  def to_s
    inventory_string << drink_string
  end

  private

  def inventory_string
    "Inventory\n" <<
    inventory.values.map do |item|
      "#{item},#{item.quantity}"
    end.join("\n")
  end

  def drink_string
    "\nMenu:\n" <<
    drinks.map.with_index(1) do |drink, i|
      "#{i},#{"%s,$%0.2f,%s" % [drink, drink_maker.price(drink), drink_maker.available(drink)]}"
    end.join("\n")
  end

  def drink_maker
    @drink_maker ||= DrinkMaker.new(inventory)
  end
end
