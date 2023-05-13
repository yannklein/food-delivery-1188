require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def login
    # ask for username in the view, store in variable
    username = @sessions_view.ask_user_for(:username)
    # ask for password in the view, store in variable
    password = @sessions_view.ask_user_for(:password)
    # check if username password corresponds to a user in @employees
    employee = @employee_repository.find_by_username(username)
    # if yes return the employee
    if !employee.nil? && employee.password == password
      return employee
    end
    # if not tell them it wrong in the view and ask to login again
    @sessions_view.wrong_password
    login
  end
end