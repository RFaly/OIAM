# create a default admin
# login: admin@admin.oiam
# password: admin@admin.oiam

Admin.create(email: "emmanuelle@vandepitterie.fr", password:"incorect-pass", first_name: "Emmanuelle", last_name: "Vandepitterie", metier:"CEO")
Admin.create(email: "loic@rakotozafy.fr", password:"incorect-pass", first_name: "Loic", last_name: "Rakotozafy", metier:"Data Analyst")
Admin.create(email: "brian@lombert.fr", password:"incorect-pass", first_name: "Brian", last_name: "Lombert", metier:"CFO")
Admin.create(email: "isabelle@deleskiewicz.fr", password:"incorect-pass", first_name: "Isabelle", last_name: "Deleskiewicz", metier:"Communication Manager")
Admin.create(email: "admin@admin.oiam", password:"admin@admin.oiam", first_name: "test", last_name: "Admin", metier:"Admin default")

puts "~~~"*12
puts "login: admin@admin.oiam"
puts "password: admin@admin.oiam"
puts "Admin created"
puts "~~~"*12