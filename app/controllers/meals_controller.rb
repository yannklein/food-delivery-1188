require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    display_meals
  end

  def add
    # ask user for the name (store in a variable)
    name = @meals_view.ask_user_for(:name)
    # ask user for the price (store in a variable)
    price = @meals_view.ask_user_for(:price)
    # create Meal instance (with name, price)
    meal = Meal.new(name: name, price: price)
    # pass it to 'create' method of repository (to be saved in the CSV)
    @meal_repository.create(meal)
    # list the meals again
    display_meals
  end

  private 

  def display_meals
    #  get array of Meals instance from repo
    meals = @meal_repository.all
    # pass array to view for it to display
    @meals_view.display(meals)
  end
end