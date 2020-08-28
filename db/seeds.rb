# create a default admin
# login: admin@admin.oiam
# password: admin@admin.oiam

Admin.destroy_all
Formation.destroy_all

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

Formation.create(name: "COACHING INDIVIDUEL", description: "Séance d'une heure avec débriefing", prix: nil)
Formation.create(name: "PROGRAMME SUR-MESURE", description: "Débriefing d'une heure avec séance personnalisé.  Débriefing 100€ TTC.  Séance 60€ TTC	par heure.", prix: 160)
Formation.create(name: "SÉANCE COLLECTIVE", description: "Séance d'une heure collective  Séance 60€ TTC/personne", prix: 60)
