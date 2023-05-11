require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @customers = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def all
    @customers
  end

  def create(customer)
    customer.id = @next_id
    @customers << customer
    @next_id += 1
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # row is a hash with key (symbol) and value ()
      # row -->  {id: "1", name: "Yann", address: "Merguo"}
      row[:id] = row[:id].to_i
      # row -->  {id: 1, name: "Yann", address: "Merguo"}
      @customers << Customer.new(row)
    end
    # @next_id = @customer.empty? ? = 1 : @customers.last.id + 1
    @next_id = @customers.last.id + 1 unless @customers.empty?
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << ['id','name','address']
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end