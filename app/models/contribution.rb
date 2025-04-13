class Contribution < ApplicationRecord
  belongs_to :participant
  belongs_to :tontine # Pour garder une trace de la tontine à laquelle la contribution appartient
  belongs_to :tour, optional: true # Une contribution est liée à un tour (peut être optionnel initialement)

  attribute :montant, :decimal
  attribute :date, :date, default: -> { Date.today }

  validates :participant_id, presence: true
  validates :tontine_id, presence: true
  validates :montant, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true
end