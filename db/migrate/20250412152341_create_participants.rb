class CreateParticipants < ActiveRecord::Migration[8.0]
  def change
    create_table :participants do |t|
      t.references :personne, null: false, foreign_key: true
      t.references :tontine, null: false, foreign_key: true
      t.date :date_d_adhesion
      t.decimal :montant_contribution_initiale
      t.string :role
      t.string :statut

      t.timestamps
    end
  end
end
