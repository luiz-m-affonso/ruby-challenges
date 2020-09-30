require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    load_csv if File.exist?(@csv_file_path)
  end

  def all_delivery_guys
    @employees.select { |employee| employee.delivery_guy? }
  end

  def find(employee_id)
    @employees.find { |employee| employee.id == employee_id }
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  private

  def load_csv
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id]        = row['id'].to_i
      row[:username]  = row['username']
      row[:password]  = row['password']
      row[:role]      = row['role']
      @employees << Employee.new(row)
    end
  end
end
