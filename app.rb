# TODO: require relevant files to bootstrap the app.
# Then you can test your program with:
#   ruby app.rb

require_relative 'router'
require_relative 'app/controllers/meals_controller'
require_relative 'app/repositories/meal_repository'

require_relative 'app/controllers/customers_controller'
require_relative 'app/repositories/customer_repository'

require_relative 'app/controllers/sessions_controller'
require_relative 'app/repositories/employee_repository'

MEAL_CSV_FILE = File.join(__dir__, 'data/meals.csv')
CUSTOMER_CSV_FILE = File.join(__dir__, "data/customers.csv")
EMPLOYEE_CSV_FILE = File.join(__dir__, "data/employees.csv")

meal_repository = MealRepository.new(MEAL_CSV_FILE)
meals_controller = MealsController.new(meal_repository)

customer_repository = CustomerRepository.new(CUSTOMER_CSV_FILE)
customers_controller = CustomersController.new(customer_repository)

employee_repository = EmployeeRepository.new(EMPLOYEE_CSV_FILE)
sessions_controller = SessionsController.new(employee_repository)

router = Router.new(meals_controller, customers_controller, sessions_controller)
router.run