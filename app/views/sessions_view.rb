class SessionsView
  def ask_user_for(something)
    puts "What #{something}?"
    gets.chomp
  end

  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1}. #{employee.username}"
    end
  end

  def wrong_password
    puts 'You shall not pass(word)!'
  end
end