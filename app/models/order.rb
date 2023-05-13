class Order
  attr_reader :meal, :customer, :employee, :done
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id] # should be an Integer
    @meal = attributes[:meal] # should be an instance of Meal
    @customer = attributes[:customer] # should be an instance of Customer
    @employee = attributes[:employee] # should be an instance of Employee
    @delivered = attributes[:delivered] || false # should be a Boolean
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end