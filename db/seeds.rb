# create a default admin
# login: admin@admin.oiam
# password: admin@admin.oiam

if Country.count == 0 && Region.count == 0 && Ville.count == 0
  franceData = [
    { region: 'Auvergne-Rhône-Alpes', departement: ['Ain', 'Allier', 'Ardèche ', 'Cantal', 'Drôme', 'Isère', 'Loire ', 'Haute-Loire ', 'Puy-de-Dôme', ' Rhône + Métropole de Lyon', 'Savoie', 'Haute-Savoie'] },
    { region: 'Bourgogne-Franche-Comté', departement: ["Côte-d'Or", 'Doubs', 'Jura', 'Nièvre', 'Haute-Saône', 'Saône-et-Loire', 'Yonne', 'Territoire de Belfort'] },
    { region: 'Bretagne', departement: ["Côtes-d'Armor", 'Finistère', 'Ille-et-Vilaine', 'Morbihan'] },
    { region: 'Centre-Val de Loire', departement: ['Cher', 'Eure-et-Loir', 'Indre', 'Indre-et-Loire', 'Loir-et-Cher', 'Loiret'] },
    { region: 'Corse', departement: ['Corse-du-Sud', 'Haute-Corse'] },
    { region: 'Grand Est', departement: ['Ardennes', 'Aube', 'Marne', 'Haute-Marne', 'Meurthe-et-Moselle', 'Meuse', 'Moselle', 'Bas-Rhin', 'Haut-Rhin', 'Vosges'] },
    { region: 'Hauts-de-France', departement: ['Aisne', 'Nord', 'Oise', 'Pas-de-Calais', 'Somme'] },
    { region: 'Île-de-France', departement: ['Paris', 'Seine-et-Marne', 'Yvelines', 'Essonne', 'Hauts-de-Seine', 'Seine-Saint-Denis', 'Val-de-Marne', "Val-d'Oise"] },
    { region: 'Normandie', departement: ['Calvados', 'Eure', 'Manche', 'Orne', 'Seine-Maritime'] },
    { region: 'Nouvelle-Aquitaine', departement: ['Charente', 'Charente-Maritime', 'Corrèze', 'Creuse', 'Dordogne', 'Gironde', 'Landes', 'Lot-et-Garonne', 'Pyrénées-Atlantiques', 'Deux-Sèvres', 'Vienne', 'Haute-Vienne'] },
    { region: 'Occitanie', departement: ['Ariège', 'Aude', 'Aveyron', 'Gard', 'Haute-Garonne', 'Gers', 'Hérault', 'Lot', 'Lozère', 'Hautes-Pyrénées', 'Pyrénées-Orientales', 'Tarn', 'Tarn-et-Garonne'] },
    { region: 'Pays de la Loire', departement: ['Loire-Atlantique', 'Maine-et-Loire', 'Mayenne', 'Sarthe', 'Vendée'] },
    { region: "Provence-Alpes-Côte d'Azur", departement: ['Alpes-de-Haute-Provence', 'Hautes-Alpes', 'Alpes-Maritimes', 'Bouches-du-Rhône', 'Var', 'Vaucluse'] },
    { region: "Toutes les régions", departement: ['Tous les départements']}
  ];

  country = Country.create(name:"France")

  franceData.each do |data|
    region = Region.create(name: data[:region], country: country)
    data[:departement].each do |dptm|
      Ville.create(name: dptm, region: region)
    end
  end

end

if Admin.count == 0
  Admin.create(email: "emmanuelle@vandepitterie.fr", password:"incorect-pass", first_name: "Emmanuelle", last_name: "Vandepitterie", metier:"CEO")
  Admin.create(email: "loic@rakotozafy.fr", password:"incorect-pass", first_name: "Loic", last_name: "Rakotozafy", metier:"Data Analyst")
  Admin.create(email: "brian@lombert.fr", password:"incorect-pass", first_name: "Brian", last_name: "Lombert", metier:"CFO")
  Admin.create(email: "isabelle@deleskiewicz.fr", password:"incorect-pass", first_name: "Isabelle", last_name: "Deleskiewicz", metier:"Communication Manager")
  Admin.create(email: "admin@admin.oiam", password:"admin@admin.oiam", first_name: "test", last_name: "Admin", metier:"Admin default")
end

if Formation.count == 0
  Formation.create(name: "COACHING INDIVIDUEL", description: "Séance d'une heure avec débriefing", prix: nil)
  Formation.create(name: "PROGRAMME SUR-MESURE", description: "Débriefing d'une heure avec séance personnalisé.  Débriefing 100€ TTC.  Séance 60€ TTC par heure.", prix: 160)
  Formation.create(name: "SÉANCE COLLECTIVE", description: "Séance d'une heure collective  Séance 60€ TTC/personne", prix: 60)
end

if Metier.count == 0
  typeMetier = ["Administration - Services généraux","Audit","Commercial-Vente","Communication-Création","Conseil","Direction générale - Direction centre de profits","Etudes - Recherche","Export","Gestion - Comptabilité - Finance","Internet - E-commerce","Juridique - Fiscal","Logistique - Achats - Stocks - Transport","Marketing","Production - Maintenance - Qualité - Sécurité - Environnement","RH - Personnel - Formation","Santé (Industrie)","Santé (Médical) - Social","Systèmes d'information - Telecom"]
  typeMetier.each do |dataName|
    Metier.create(name: dataName)
  end
end
