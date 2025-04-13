class Tontine < ApplicationRecord
  belongs_to :creator, class_name: 'Personne', foreign_key: 'organisateur_id'

  has_many :participants, dependent: :destroy
  has_many :personnes, through: :participants
  has_many :tours, dependent: :destroy
  has_many :contributions, dependent: :destroy

  # Attributs essentiels
  validates :description, presence: true
  validates :frequence, presence: true, inclusion: { in: ["Hebdomadaire", "Mensuelle", "Annuelle"] }
  validates :montant, presence: true, numericality: { greater_than: 0 }
  validates :statut, inclusion: { in: ["Ouverte", "Fermée", "Terminée"], allow_blank: true }

  # Attributs optionnels (à considérer selon vos besoins)
  attribute :date_de_debut, :date
  validates :date_de_debut, presence: true, if: :ouverte? # Exemple de validation conditionnelle

  attribute :nombre_de_participants_max, :integer
  validates :nombre_de_participants_max, numericality: { only_integer: true, greater_than: 1, allow_nil: true }
  validate :nombre_de_participants_non_atteint, if: :ouverte?

  # Méthodes pour gérer le statut
  def ouverte?
    statut == "Ouverte"
  end

  def fermee?
    statut == "Fermée"
  end

  def terminee?
    statut == "Terminée"
  end

  def peut_rejoindre?
    ouverte? && (nombre_de_participants_max.nil? || participants.count < nombre_de_participants_max)
  end

  private

  def nombre_de_participants_non_atteint
    if nombre_de_participants_max.present? && participants.count >= nombre_de_participants_max
      errors.add(:base, "Le nombre maximum de participants a été atteint.")
    end
  end
end