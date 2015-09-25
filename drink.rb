class Drink
  attr_accessor :name, :ingredients

  def initialize(name, ingredients = {})
    @name = name
    @ingredients = ingredients
  end

  def to_s
    name
  end
end
