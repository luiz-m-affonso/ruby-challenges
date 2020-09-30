require_relative '../views/meals_view'
require_relative '../models/meal'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealsView.new
  end

  def add
    name =  @view.ask_for('name')
    price = @view.ask_for('price').to_i
    meal = Meal.new(name: name, price: price)
    @meal_repository.create(meal)
  end

  def list
    @view.display(@meal_repository.all)
  end
end
