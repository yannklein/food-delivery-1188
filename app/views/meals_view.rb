class MealsView
  def display(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1}. #{meal.name} (¥#{meal.price})"
    end
  end

  def ask_user_for(something)
    puts "What #{something}?"
    gets.chomp
  end
end