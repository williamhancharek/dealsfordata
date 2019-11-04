# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([ name: 'Star Wars' ,  name: 'Lord of the Rings' ])
#   Character.create(name: 'Luke', movie: movies.first)

customers = User.create([{email: "c1@c.com",
                        role: "customer",
                        search_terms: "I like skateboards looking for a cool thing like that",
                        keywords: "skateboards cool",
                        password: "tentenfour"},
                        {email: "c2@c.com",
                        role: "customer",
                        search_terms: "diamond rings and other wedding gifts",
                        keywords: "rings diamond wedding",
                        password: "tentenfour"},
                        {email: "c3@c.com",
                        role: "customer",
                        search_terms: "fluffy pet toys",
                        keywords: "fluffy pet toys",
                        password: "tentenfour"}])
customers.each {|t| t.attach_identicon}

merchants = User.create([{email: "m1@m.com",
                          role: "merchant",
                          password: "tentenfour"},
                          {email: "m2@m.com",
                          role: "merchant",
                          password: "tentenfour"},
                          {email: "m3@m.com",
                          role: "merchant",
                          password: "tentenfour"}])
merchants.each {|t| t.attach_identicon}

employees = User.create([{email: "e1@e.com",
                          role: "employee",
                          password: "tentenfour"},
                          {email: "e2@e.com",
                          role: "employee",
                          password: "tentenfour"},
                          {email: "e3@e.com",
                          role: "employee",
                          password: "tentenfour"}])
employees.each {|t| t.attach_identicon}

admin = User.create([{email: "a1@a.com",
                      role: "admin",
                      password: "tentenfour"},
                      {email: "a2@a.com",
                      role: "admin",
                      password: "tentenfour"}])
admin.each {|t| t.attach_identicon}
