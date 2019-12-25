# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([ name: 'Star Wars' ,  name: 'Lord of the Rings' ])
#   Character.create(name: 'Luke', movie: movies.first)
customers = User.create([{email: "c1@c.com",
                        role: "customer",
                        password: "tentenfour"},
                        {email: "c2@c.com",
                        role: "customer",
                        password: "tentenfour"},
                        {email: "c3@c.com",
                        role: "customer",
                        password: "tentenfour"}])

customers.each do |t|
  t.boxes.build(search_terms: "search terms #{t.id}", name: "test search box #{t.id}")
end

merchants = User.create([{email: "m1@m.com",
                          role: "merchant",
                          name: "merchant 1",
                          password: "tentenfour"},
                          {email: "m2@m.com",
                          name: "merchant 2",
                          role: "merchant",
                          password: "tentenfour"},
                          {email: "m3@m.com",
                          role: "merchant",
                          name: "merchant 3",
                          password: "tentenfour"}])

merchants.each do |t|
  t.campaigns.build(name: "campaign: #{t.name}")
end

employees = User.create([{email: "e1@e.com",
                          role: "employee",
                          password: "tentenfour"},
                          {email: "e2@e.com",
                          role: "employee",
                          password: "tentenfour"},
                          {email: "e3@e.com",
                          role: "employee",
                          password: "tentenfour"}])

admin = User.create([{email: "a1@a.com",
                      role: "admin",
                      password: "tentenfour"},
                      {email: "a2@a.com",
                      role: "admin",
                      password: "tentenfour"}])

admin.each do |t|
  t.attach_identicon
  t.confirm
  t.save
end

employees.each do |t|
  t.attach_identicon
  t.confirm
  t.save
end

merchants.each do |t|
  t.attach_identicon
  t.confirm
  t.save
end

customers.each do |t|
  t.attach_identicon
  t.confirm
  t.save
end
