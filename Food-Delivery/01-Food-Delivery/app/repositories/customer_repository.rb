require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @customers = []
    load_csv if File.exist?(@csv_file_path)
  end

  def create(customer)
    next_id = @customers.empty? ? 1 : @customers.last.id + 1
    customer.id = next_id
    @customers << customer
    save_to_csv
  end

  def all
    @customers
  end

  def find(customer_id)
    @customers.find { |customer| customer.id == customer_id }
  end

  private

  def save_to_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      csv << ['id', 'name', 'address']
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def load_csv
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row['id'].to_i
      row[:name] = row['name']
      row[:address] = row['address']
      @customers << Customer.new(row)
    end
  end
end
