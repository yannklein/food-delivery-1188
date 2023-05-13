class OrdersView
  def display(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1}.[#{order.delivered? ? "X" : " "}] #{order.meal.name} for #{order.customer.name} by #{order.employee.username}"
    end
  end

  def ask_user_for(something)
    puts "What #{something}?"
    gets.chomp
  end
end