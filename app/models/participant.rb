class Participant < ApplicationRecord
  belongs_to :personne
  belongs_to :tontine

  has_many :contributions, dependent: :destroy

  attribute :date_d_adhesion, :date
  attribute :montant_contribution_initiale, :decimal
  attribute :role, :string # Exemple: 'Membre', 'Président', etc.
  attribute :statut, :string # Exemple: 'Actif', 'Inactif', 'Suspendu'

  validates :personne_id, presence: true
  validates :tontine_id, presence: true
  validates :personne_id, uniqueness: { scope: :tontine_id, message: "est déjà participant à cette tontine" }
end