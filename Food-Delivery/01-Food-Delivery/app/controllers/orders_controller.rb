require_relative '../views/orders_view'
require_relative '../models/order'
class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository     = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository    = order_repository
    @view = OrdersView.new
  end

  def add
    meals = @meal_repository.all
    meal_index = @view.display_meals_and_ask_for_index(meals)
    meal = meals[meal_index]
    customers = @customer_repository.all
    customer_index = @view.display_customers_and_ask_for_index(customers)
    customer = customers[customer_index]
    employees = @employee_repository.all_delivery_guys
    employee_index = @view.display_employees_and_ask_for_index(employees)
    employee = employees[employee_index]
    order = Order.new(
      meal: meal,
      customer: customer,
      employee: employee
    )
    @order_repository.create(order)
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @view.display(orders)
  end

  def list_my_orders(employee)
    orders = @order_repository.undelivered_orders
    orders = orders.select { |order| order.employee.id == employee.id }
    @view.display(orders)
    orders
  end

  def mark_as_delivered(employee)
    orders = list_my_orders(employee)
    order_index = @view.ask_order_index_to_be_delivered
    order = orders[order_index]
    @order_repository.deliver(order)
  end
end
