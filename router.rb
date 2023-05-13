# TODO: implement the router of your app.


class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @running = true
    @current_user = nil
  end
  
  def run
    while @running
      # login
      welcome_action
      until @current_user.nil?
        # show the right menu/actions according to the user privilegies
        if @current_user.rider? 
          route_rider_action
        else
          route_manager_action
        end
      end
    end
  end

  def welcome_menu
    puts "-----------------------"
    puts "------- WELCOME -------"
    puts "-----------------------"
    puts "1. Login"
    puts "8. Exit"
    print "> "
  end

  def welcome_action
    welcome_menu
    user_choice = gets.chomp.to_i
    print `clear`
    case user_choice
    when 1 then @current_user = @sessions_controller.login
    when 8 then stop!
    else
      puts "Wrong command! try again"
    end
  end

  def print_rider_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. Add new meal"
    puts "2. List all meals"
    puts "7. Logout"
    puts "8. Exit"
    print "> "
  end

  def print_manager_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. Add new meal"
    puts "2. List all meals"
    puts "3. Add new customer"
    puts "4. List all customers"
    puts "7. Logout"
    puts "8. Exit"
    print "> "
  end

  def route_rider_action
    print_rider_menu
    user_choice = gets.chomp.to_i
    print `clear`
    case user_choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 7 then @current_user = nil
    when 8 then stop!
    else
      puts "Wrong command! try again"
    end
  end
  
  def route_manager_action
    print_manager_menu
    user_choice = gets.chomp.to_i
    print `clear`
    case user_choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 7 then @current_user = nil
    when 8 then stop!
    else
      puts "Wrong command! try again"
    end
  end

  def stop!
    @current_user = nil
    @running = false
  end
end