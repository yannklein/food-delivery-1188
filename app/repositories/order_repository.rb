require 'csv'
require_relative '../models/order'

class OrderRepository
  def initialize(csv_file, meal_repository, customer_repository, employee_repository)
    @csv_file = csv_file
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def create(new_order)
    new_order.id = @next_id
    @next_id += 1
    @orders << new_order
    save_csv
  end

  def delivered(order)
    order.deliver!
    save_csv
  end

  def all
    @orders
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def find(id)
    @orders.find { |order| order.id == id}
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      #  row --> {id: "1", delivered: "true", meal_id: "1", customer_id: "1", employee_id: "2"}
      row[:id] = row[:id].to_i
      #  row --> {id: 1, delivered: "true", meal_id: "1", customer_id: "1", employee_id: "2"}
      row[:delivered] = row[:delivered] == "true"
      #  row --> {id: 1, delivered: true, meal_id: "1", customer_id: "1", employee_id: "2"}
      meal = @meal_repository.find(row[:meal_id].to_i)
      row[:meal] = meal
      #  row --> {id: 1, delivered: true, meal: instance of Meal, meal_id: "1", customer_id: "1", employee_id: "2"}
      customer = @customer_repository.find(row[:customer_id].to_i)
      row[:customer] = customer
      employee = @employee_repository.find(row[:employee_id].to_i)
      row[:employee] = employee
      #  row --> {id: 1, delivered: true, meal: instance of Meal, customer: instance of Customer, employee: instance of Employee }
      @orders << Order.new(row)
    end
    # @next_id = @orders.empty? 1 : @orders.last + 1
    @next_id = @orders.last.id + 1 unless @orders.empty?
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << ['id', 'delivered', 'meal_id', 'customer_id', 'employee_id']
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end
end