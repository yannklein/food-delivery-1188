# TODO: require relevant files to bootstrap the app.
# Then you can test your program with:
#   ruby app.rb

require_relative 'router'
require_relative 'app/controllers/meals_controller'
require_relative 'app/repositories/meal_repository'

require_relative 'app/controllers/customers_controller'
require_relative 'app/repositories/customer_repository'

MEAL_CSV_FILE = File.join(__dir__, 'data/meals.csv')
CUSTOMER_CSV_FILE = File.join(__dir__, "data/customers.csv")

meal_repository = MealRepository.new(MEAL_CSV_FILE)
meals_controller = MealsController.new(meal_repository)

customer_repository = CustomerRepository.new(CUSTOMER_CSV_FILE)
customers_controller = CustomersController.new(customer_repository)

router = Router.new(meals_controller, customers_controller)
router.run