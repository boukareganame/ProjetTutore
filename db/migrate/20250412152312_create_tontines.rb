class CreateTontines < ActiveRecord::Migration[8.0]
  def change
    create_table :tontines do |t|
      t.string :description
      t.string :frequence
      t.decimal :montant
      t.string :statut
      t.references :organisateur, foreign_key: { to_table: :personnes }

      t.timestamps
    end
  end
end
