require 'csv'
require_relative '../models/order'
class OrderRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = csv_file_path

    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    load_csv if File.exist?(@csv_file_path)
  end

  def create(order)
    next_id = @orders.empty? ? 1 : @orders.last.id + 1
    order.id = next_id
    @orders << order
    save_to_csv
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def deliver(order)
    order.deliver!
    save_to_csv
  end

  private

  def save_to_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      csv << ['id', 'delivered', 'meal_id', 'customer_id', 'employee_id']
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end

  def load_csv
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id]        = row['id'].to_i
      row[:delivered] = row['delivered'] == 'true'
      row[:meal]      = @meal_repository.find(row['meal_id'].to_i)
      row[:customer]  = @customer_repository.find(row['customer_id'].to_i)
      row[:employee]  = @employee_repository.find(row['employee_id'].to_i)
      @orders << Order.new(row)
    end
  end
end
