require_relative '../views/employees_view'

class SessionsController
  def initialize(employees_repository)
    @employees_repository = employees_repository
    @view = EmployeesView.new
  end

  def login
    username = @view.ask_for('username')
    password = @view.ask_for('password')
    employee = @employees_repository.find_by_username(username)
    if employee && employee.password == password
      return employee
    else
      @view.wrong_credentials
      # recursive call
      login
    end
  end
end
