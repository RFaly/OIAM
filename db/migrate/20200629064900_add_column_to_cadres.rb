class AddColumnToCadres < ActiveRecord::Migration[5.2]
  def change
    add_column :cadres, :image, :string
    add_column :cadres, :first_name, :string
    add_column :cadres, :last_name, :string
    add_column :cadres, :adresse, :string
    add_column :cadres, :status, :string
    add_column :cadres, :situation, :string
    add_column :cadres, :telephone, :string
    add_column :cadres, :potential_test, :integer
    add_column :cadres, :skils_test, :integer
    add_column :cadres, :fit_test, :boolean
    add_column :cadres, :avis_recruteur, :text
    add_column :cadres, :question1, :text
    add_column :cadres, :question2, :text
    add_column :cadres, :question3, :text
    add_column :cadres, :question4, :text
    add_column :cadres, :question5, :text
  end
end
