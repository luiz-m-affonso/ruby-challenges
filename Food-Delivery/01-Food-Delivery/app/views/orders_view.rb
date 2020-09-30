class OrdersView
  def ask_order_index_to_be_delivered
    puts "Which order did you just deliver? Provide the number"
    gets.chomp.to_i - 1
  end

  def display(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1} [ ]: #{order.meal.name} to #{order.customer.name} by #{order.employee.username}"
    end
  end

  def display_meals_and_ask_for_index(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1}: #{meal.name} - R$ #{meal.price}"
    end
    puts "Which meal do you want? Give me the index"
    gets.chomp.to_i - 1
  end

  def display_customers_and_ask_for_index(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1}: #{customer.name} at #{customer.address}"
    end
    puts "Which customer do you want? Give me the index"
    gets.chomp.to_i - 1
  end

  def display_employees_and_ask_for_index(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1}: #{employee.username}"
    end
    puts "Which employee do you want? Give me the index"
    gets.chomp.to_i - 1
  end
end
