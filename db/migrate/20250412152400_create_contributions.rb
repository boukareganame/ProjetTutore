class CreateContributions < ActiveRecord::Migration[8.0]
  def change
    create_table :contributions do |t|
      t.references :participant, null: false, foreign_key: true
      t.references :tontine, null: false, foreign_key: true
      t.decimal :montant
      t.date :date

      t.timestamps
    end
  end
end
