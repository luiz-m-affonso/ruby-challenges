class MealsView
  def ask_for(field)
    puts "What's the #{field} of the meal?"
    gets.chomp
  end

  def display(meals)
    meals.each do |meal|
      puts "#{meal.name} -> R$ #{meal.price}"
    end
  end
end
