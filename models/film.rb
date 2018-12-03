require_relative('../db/sql_runner')
require_relative('./customer')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price)
          VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map { |film| Film.new(film)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql)
  end

  def customers()
    sql = "SELECT customers.*
          FROM customers INNER JOIN tickets
          ON customers.id = tickets.customer.id
          WHERE ticket.film_id = $1"
    values = [@id]
    customers = customer_array.map {|customer_hash|Costomer.new(customer_hash)}
    return customer
  end

  def sell_ticket()
    customer.request_money(@price)
    @total_cash += @price
  end

end
