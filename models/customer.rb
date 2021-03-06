require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name,funds)
    VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run( sql, values ).first
    @id = customer['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new( customer ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def films()
    sql = "SELECT films.*
    FROM films INNER JOIN visits
    ON films.id = tickets.film_id
    WHERE ticket.customer_id = $1"
    values = [@id]
    film_array = SqlRunner.run(sql, values)
    films = film_array.map {|film_hash|Film.new(film_hash)}
    return film
  end

  def request_money(price)
  @funds -= price
  return price
end

end
