class SessionsView
  def ask_user_for(something)
    puts "What #{something}?"
    gets.chomp
  end

  def wrong_password
    puts 'You shall not pass(word)!'
  end
end