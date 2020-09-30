class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
  end

  def run
    @running = true
    # Declare Variable to Run the While Loop
    while @running
      @employee = @sessions_controller.sign_in

      while @employee
        # While Loop with a sequence of Conditionals
        if @employee.manager?
          display_manager_options
          user_answer = gets.chomp
          route_to_manager_actions(user_answer.to_i)
        else
          display_delivery_options
          user_answer = gets.chomp
          route_to_delivery_actions(user_answer.to_i)
        end
      end
    end
  end

  private

  def display_manager_options
    puts "Welcome to Food Delivery!"
    puts "========================="
    puts "1 - Add a new meal"
    puts "2 - List all meals"
    puts "3 - Add a new customer"
    puts "4 - List all customers"
    puts "5 - Add a new order"
    puts "6 - List undelivered orders"
    puts "8 - Sign out"
    puts "9 - Exit"
  end

  def route_to_manager_actions(user_answer)
    case user_answer
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then puts "TO-DO: Orders stuff"
    when 6 then puts "TO-DO: Orders stuff"
    when 8 then @employee = nil
    when 9
      @running  = false
      @employee = nil
    else
      puts "Invalid option, please choose another one."
    end
  end

  def display_delivery_options
    puts "Welcome to Food Delivery!"
    puts "========================="
    puts "1 - Mark an order as delivered"
    puts "2 - List undelivered orders"
    puts "8 - Sign out"
    puts "9 - Exit"
  end

  def route_to_delivery_actions(user_answer)
    case user_answer
    when 1 then puts "TO-DO: Orders stuff"
    when 2 then puts "TO-DO: Orders stuff"
    when 8 then @employee = nil
    when 9
      @running  = false
      @employee = nil
    else
      puts "Invalid option, please choose another one."
    end
  end
end
