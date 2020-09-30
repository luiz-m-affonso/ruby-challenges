class Meal
  attr_reader :name, :price
  attr_accessor :id

  # Constructor method
  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @price = attributes[:price]
  end
end
