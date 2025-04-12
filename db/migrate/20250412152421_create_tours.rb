class CreateTours < ActiveRecord::Migration[8.0]
  def change
    create_table :tours do |t|
      t.integer :ordre
      t.references :tontine, null: false, foreign_key: true
      t.references :beneficiaire, foreign_key: { to_table: :personnes }
      t.date :date_tirage
      t.boolean :beneficiaire_aleatoire

      t.timestamps
    end
  end
end
