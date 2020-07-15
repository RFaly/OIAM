class CreateCadreInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :cadre_infos do |t|
      t.string :image
      t.string :first_name
      t.string :last_name
      t.string :adresse
      t.string :postal_code
      t.string :city
      t.string :mail
      t.string :status
      t.string :situation
      t.string :telephone
      t.integer :potential_test
      t.integer :skils_test
      t.boolean :fit_test
      t.text :avis_recruteur
      t.text :question1
      t.text :question2
      t.text :question3
      t.text :question4
      t.text :question5
      t.belongs_to :cadre
      
      t.timestamps
    end
  end
end
