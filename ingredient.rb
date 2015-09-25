class Ingredient
  attr_accessor :name, :quantity, :price

  def initialize(name, quantity, price=nil)
    @name = name
    @quantity = quantity
    @price = price
  end

  def to_s
    name
  end
end
