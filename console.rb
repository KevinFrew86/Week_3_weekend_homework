require_relative( './models/film' )
require_relative( './models/customer' )
require_relative( './models/ticket' )

require ( 'pry-byebug')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({ 'name' => 'John', 'funds' => '500'})
customer1.save()

customer2 = Customer.new({'name' => 'Nas', 'funds' => '1000'})
customer2.save()

customer3 = Customer.new({'name' => 'Kate', 'funds' => '2000'})
customer3.save()


film1 = Film.new({ 'title' => 'Shite', 'price' => '900'})
film1.save()

film2 = Film.new({ 'title' => 'Shite 2', 'price' => '900'})
film2.save()


ticket1 = Ticket.new({ 'cust_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

ticket2 = Ticket.new({ 'cust_id' => customer1.id, 'film_id' => film2.id})
ticket2.save()

ticket3 = Ticket.new({ 'cust_id' => customer2.id, 'film_id' => film1.id})
ticket3.save()

ticket4 = Ticket.new({ 'cust_id' => customer3.id, 'film_id' => film2.id})
ticket4.save()

binding.pry
nil
