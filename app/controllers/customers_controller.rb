require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    display_customers
  end

  def add
    # ask user for the name (store in a variable)
    name = @customers_view.ask_user_for(:name)
    # ask user for the address (store in a variable)
    address = @customers_view.ask_user_for(:address)
    # create Customer instance (with name, address)
    customer = Customer.new(name: name, address: address)
    # pass it to 'create' method of repository (to be saved in the CSV)
    @customer_repository.create(customer)
    # list the customers again
    display_customers
  end

  private 

  def display_customers
    #  get array of Customers instance from repo
    customers = @customer_repository.all
    # pass array to view for it to display
    @customers_view.display(customers)
  end
end