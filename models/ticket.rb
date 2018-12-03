require_relative('../db/sql_runner')
require_relative('./film')
require_relative('./customer')

class Ticket

  attr_reader :id
  attr_accessor :cust_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @cust_id = options['cust_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (cust_id, film_id)
    VALUES ($1, $2) RETURNING id"
    values = [@cust_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    values = []
    tickets = SqlRunner.run(sql, values)
    result = tickets.map { |ticket| Ticket.new( ticket)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)

  end

  def film()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    film_hash = SqlRunner.run(sql, values)[0]
    film = Film.new(film_hash)
    return film
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@cust_id]
    customer_hash = SqlRunner.run(sql, values)[0]
    customer = Customer.new(customer_hash)
    return customer
  end

end
