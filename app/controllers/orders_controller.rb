
require_relative '../views/meals_view'
require_relative '../views/customers_view'
require_relative '../views/sessions_view'
require_relative '../views/orders_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @sessions_view = SessionsView.new
    @orders_view = OrdersView.new
  end

  def list_undelivered_orders
    # get undelivered orders from the order repo
    orders = @order_repository.undelivered_orders
    # display them
    @orders_view.display(orders)
  end

  def add
    # list/display all the meals
    meals = @meal_repository.all
    @meals_view.display(meals)
    # ask the user for a meal index (convert integer - 1)
    meal_index = @meals_view.ask_user_for(:index).to_i - 1
    # search for the meal in the meals array according index
    meal = meals[meal_index]

    # list/display all the customers
    customers = @customer_repository.all
    @customers_view.display(customers)
    # ask the user for a customer index (convert integer - 1)
    customer_index = @customers_view.ask_user_for(:index).to_i - 1
    # search for the customer in the customers array according index
    customer = customers[customer_index]

    # list/display all the riders
    riders = @employee_repository.all_riders
    @sessions_view.display(riders)
    # ask the user for a rider index (convert integer - 1)
    rider_index = @sessions_view.ask_user_for(:index).to_i - 1
    # search for the rider in the meals array according index
    rider = riders[rider_index]

    # create an order with them
    order = Order.new(meal: meal, customer: customer, employee: rider)
    # give it to the repo to be saved 
    @order_repository.create(order)
    # list orders
    display_orders
  end

  def mark_as_delivered
    # show orders
    orders = display_orders
    # ask user for an index (convert to i -1)
    order_index = @orders_view.ask_user_for(:index).to_i - 1
    # get the order from the array
    order = orders[order_index]
    # mark as done
    @order_repository.mark_as_delivered(order)
    # list orders
    display_orders
  end

  private

  def display_orders
    orders = @order_repository.all
    @orders_view.display(orders)
    orders
  end
end