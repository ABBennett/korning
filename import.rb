# Use this file to import the sales information into the
# the database.

require "pg"
require 'csv'
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: "korning")
    yield(connection)
  ensure
    connection.close
  end
end

@sales = []
@employees = []
@customers = []
@products = []

CSV.foreach("sales.csv", headers: true, header_converters: :symbol) do |row|
  sale = row.to_hash
  @sales << sale
end

@sales.each do |sale|
  if @employees.include? (sale[:employee])
  else @employees << sale[:employee]
  end

  if @customers.include? (sale[:customer_and_account_no])
  else @customers << sale[:customer_and_account_no]
  end

  if @products.include? (sale[:product_name])
  else @products << sale[:product_name]
  end

end


@employees.each do |employee|
  db_connection do |conn|
    conn.exec_params("
                      INSERT INTO employees (name)
                      VALUES ($1);",
                      ["#{employee}"])

  end
end

@customers.each do |customer|
  db_connection do |conn|
    conn.exec_params("
                      INSERT INTO customers (customer)
                      VALUES ($1);",
                      ["#{customer}"])

  end
end

@products.each do |product|
  db_connection do |conn|
    conn.exec_params("
                      INSERT INTO products (product)
                      VALUES ($1);",
                      ["#{product}"])

  end
end
