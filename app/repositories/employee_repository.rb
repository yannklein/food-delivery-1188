require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @employees = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def all
    @employees
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # row is a hash with key (symbol) and value ()
      # row -->  {id: "1", username: "Yann", password: "wa3456", role: "rider"}
      row[:id] = row[:id].to_i
      # row -->  {id: 1, username: "Yann", password: "wa3456", role: "rider"}
      @employees << Employee.new(row)
    end
    # @next_id = @employee.empty? ? = 1 : @employees.last.id + 1
    @next_id = @employees.last.id + 1 unless @employees.empty?
  end
end