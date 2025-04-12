class CreateAdministrateurs < ActiveRecord::Migration[8.0]
  def change
    create_table :administrateurs do |t|
      t.references :personne, null: false, foreign_key: true

      t.timestamps
    end
  end
end
