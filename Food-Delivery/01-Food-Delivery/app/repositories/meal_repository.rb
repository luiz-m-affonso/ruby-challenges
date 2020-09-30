require 'csv'
require_relative '../models/meal'

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    load_csv if File.exist?(@csv_file_path)
  end

  def create(meal)
    next_id = @meals.empty? ? 1 : @meals.last.id + 1
    meal.id = next_id
    @meals << meal
    save_to_csv
  end

  def all
    @meals
  end

  def find(meal_id)
    @meals.find { |meal| meal.id == meal_id }
  end

  private

  def save_to_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      csv << ['id', 'name', 'price']

      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id]    = row['id'].to_i
      row[:price] = row['price'].to_i
      row[:name]  = row['name']

      @meals << Meal.new(row)
    end
  end
end
