class CustomersView
  def ask_for(field)
    puts "What's the #{field} of the customer?"
    gets.chomp
  end

  def display(customers)
    customers.each do |customer|
      puts "#{customer.name} at #{customer.address}"
    end
  end
end
