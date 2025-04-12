class CreatePersonnes < ActiveRecord::Migration[8.0]
  def change
    create_table :personnes do |t|
      t.string :nom
      t.string :prenom
      t.string :email
      t.string :telephone

      t.timestamps
    end
  end
end
