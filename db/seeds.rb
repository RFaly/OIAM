# create a default admin
# login: admin@admin.oiam
# password: admin@admin.oiam

Country.destroy_all
Region.destroy_all
Ville.destroy_all
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
];


country = Country.create(name:"France")
franceData.each do |data|
	region = Region.create(name: data[:region], country: country)
	data[:departement].each do |dptm|
		Ville.create(name: dptm, region: region)
	end
end


typeMetier = ["Directeur commercial","Développeur web","Directeur marketing","Manager marketing","Directeur ressource humain","Directeur du système d'information","Directeur Opérationnel","Chef de projet Ressources Humaines","Consultant en Affaires Internationales","Ingénieur d'Affaires Internationales","Assistante chargée de communication","Assistante de Direction, Assistant de Direction","Agent de protection rapprochée - APR   H/F","Acheteur International, Acheteuse Internationale","Technicien supérieur communication d'entreprise","Design Manager","Economiste d'entreprise","Assistante de Manager  Assistant de Manager","Adjoint/Adjointe au Directeur Financier","Formateur en entreprise","Cadre RH - Ressources Humaines H/F","Négociateur, Négociatrice technico commercial","Chargé - e d'affaires - Export","Ingénieur Généraliste","Analyste des marchés de l'énergie","Formateur professionnel d'adultes","Juriste d'entreprise","Chargé d'études Statistiques - Chargée ..","Technicien en électronique","Directeur du Marketing International","Psychologue du travail","Cadre -  Entraînement bureautique","Ingénieur Maître Génie Electrique et Informatique Industrielle","Assistant de Gestion Ressources Humaines; Assistante...","Qualiticien","Manager de projets","Spécialiste Business Intelligence ","Chargée de communication évènementielle","Technicien réseaux et télécommunications d'entreprise","Cadres","Agent de maintenance sur systèmes d'impression et de reprographie","Opérateur de Production","Trader International","Physicien (physique des particules)","Technicien supérieur en conception industrielle de systèmes ","Assistant (e) en ressources humaines","Technicien technicienne de production sur lignes automatisées","Assistante Contrôleur de gestion","Soudeur industriel","Trésorier International","Responsable Sécurité","Aide Comptable ","Débutant (Mandarin)","Cadre Technico Commercial Export","Responsable Mécénat","Acheteur packaging","Consultante Psychologue","Responsable des Relations Publiques","Responsable service organisation","Responsable de la Communication Financière","Agent, Agente logisticienne ","Opérateur de maintenance du matériel (SNCF)","Gestionnaire GMAO","Assistant Principal d'expert comptable","Animateur de groupe de travail","Soudeur à l'arc électrode enrobée et TIG","Chef de produits, marchés internationaux","Canalisateur","Mandataire judiciaire ","Constructeur professionnel en voirie et réseaux","Gestionnaire Vendeur","Chargé de recrutement, Chargée de recrutement ","Agent de sûreté et de sécurité privée","Adjoint Directeur des Achats","Expatrié - e","Agent de Sécurité Incendie  (qualifié ERP1)","Technicien  Contrôles non destructifs - CND ","Agent de Développement Sociologue","Responsable de la communication évènementielle","Agent commercial","Hôtesse d'Accueil, Hôtesse Standardiste","Chef de Département Distribution","Technicien  Supérieur en conception industrielle","Administrateur virtualisation des SI ","Assistant  (e) Chargé de Gestion  et des travaux comptables","Assistant (e) Chef de produit","Technicien Accrédité Compaq","Agent logisticien","Technicien aéro structure, Technicienne aéro structure","Analyste Financier Projets d'investissement","Directeur des ventes","Consultant, consultante Propriété Industrielle","Responsable commercial  Europe","Designer Produits alimentaires ","Apprenti Facteur ","Formateur Responsable de la Coordination de dispositifs de ","Chargé (e) de communication Internet","Responsable logistique","Ingénieur mécanicien","Développeur Applications et systèmes  SCADA - IHM","Assistant (e) Chef de zone - Export","Recruteur  grande distribution ","Conseiller en relations administratives publiques","Manager d'entreprise en réseau","Chef déquipe en voirie et réseaux divers","Directeur Informatique","Learner French Language (Business language)","Secrétaire (retravailler)","Ingénieur de l'Internet - Spécialisation logistique - transport","Technicien Supérieur Assistant du Responsable de Sécurité","Développeur Visual Age Java","Sénior - Grande Expérience","PhD en  Information et Société de la connaissance","Conseil en Organisation d'entreprises européennes","Expert Comptable ( Prépa)","Commercial Europe - Haut Niveau","Chef de chantier, travaux publics routes","Ingénieur d'Affaires Marché européen","Utilisateur Word","Analyste Financier","Chef de Marché en Ligne - Junior","Chef de chantier Travaux Publics Ouvrages d'Art","Sociologue -2","Attaché de Presse","Responsable de projet en systèmes d'information","Adjoint Chef de Projet - Télécom Nouveaux services","Ingénieur Informaticien ( généraliste)","Risk Manager Fr - Finance","Chaudronnier chargé d'affaires ","Technicien-ne Supérieur Exploitation Réseau Téléphonie.","Débutant ACCESS","Ingénieur Commercial H/F ","Chef de produit, marché","Chef de Projet Réalité Virtuelle","Technicien Supérieur en Electronique.","Responsable Qualité","Technicien Supérieur Maintenance Informatique","Acheteur Industriel - Europe","Comptable d'entreprise Junior","Projeteur (conception bureau d'études produits industriels)","Technicien Supérieur Organisations  Méthodes","Formatrice Micro","Standardiste","Ingénieur commercial ( B to B)","Chef de Projet Télécom","Utilisateur  Excel","Informaticien certifié CNE","Chef de projet Industrie Agroalimentaire","Secrétaire Bureautique Spécialisée Accueil Bilingue","Ingénieur électronicien","Ingénieur Exploitation Réseau Téléphonie","Ingénieur Support Technique Grands Comptes","Ingénieur CESI","Ergonome","Jeune Fonctionnaire -Pays ACP","Technicien Supérieur de Maintenance et Services en Micro ","Ingénieur en Environnement","Dirigeant/e","Trésorier","Technicien Supérieur Hautement Qualifié - Réseaux Informatiques","Journaliste en entreprise","Ingénieur Production Industrielle Option Qualité","Facilitateur","Chef de Projet Intranet","Manager d'entreprise (secteur agroalimentaire)","Ingénieur Financier","Média Planner Fr","Cadre technique de production -Exploitation de gisement ","Gestionnaire de Ressources Informatiques - Ingénieur","Assistant (e)  International Business Manager","Responsable de Centre Serveur","Consultant en télécommunications","Nouvel utilisateur Lotus Notes","Crédit-Manager F","Directeur Financier","Etudiants MCSE Microsoft","Conductrice de lignes automatisées","Acheteur Professionnel","Cadre créateur d'entreprise","Planneur Stratégique - Junior","Chargée de communication","Animatrice des ventes","Assistant (e)   Direction Européenne","Ingénieur en charge des ressources humaines","Directeur de la Communication","Manager logistique Produits","Assistant (e) Polyvalent/e de gestion Certif. Microsoft MOUS","Utilisateurs Logiciels  (bureautique)","Adjoint Chef de Projet Ingénieur Electronique","Administrateur  - Certified Lotus Specialist","Administrateur Réseau Netware - Novell","Administratrice Réseau Local - Informatique","Analyste - informatique","Analyste Financier - Banque","Architecte Systèmes d'Information","Architecte Technique -Télécom","Assistant (e) de Direction Bilingue","Assistant (e) Technique d'Ingénieur","Cadre commercial bilingue","Chargé de Communication - Europe [Adjoint]","Chef de Fabrication Adjoint -e - IAA","Chef de Projet Groupware","Chef de projet informatique","CLS - Developpeur- certifié Lotus","Commercial, Commerciale","Concepteur de systèmes Mécaniques","Concepteur Rédacteur - (Pub)","Contrôleur  de gestion","Développeur Informatique","European Business Dév. Manager","Expert en télécoms et Réseaux","Formateur  Modèle [EFQM]","Informaticien","Informaticien -Certifié MCP-SE","Ingénieur - Intégrateur Systèmes Internet","Ingénieur de conception - Electronique","Ingénieur en télécommunication","Ingénieur Généraliste Industries  Agroalimentaires","Ingénieur R&amp;D - Calcul Scientifique","Juriste européen","Manager H/F ","Rédacteur Technique Multilingue","Responsable de Formation","Responsable études financières","Responsable Export","Responsable Réseaux - Informatique","Responsable Télécommunications","Responsable zone export -","Technicien micro","Technicien Opérateur Réseau -Téléphonie","Thermicien, Thermicienne - Bureau d'Etude - Bâtiment","Tuteur en entreprise","Webmaster"]

typeMetier.each do |dataName|
  Metier.create(name: dataName)
end
