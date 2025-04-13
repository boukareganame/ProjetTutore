class Tour < ApplicationRecord
  belongs_to :tontine
  belongs_to :beneficiaire, class_name: 'Personne', optional: true

  has_many :contributions, dependent: :destroy
  has_many :participants, through: :contributions, source: :participant

  attribute :ordre, :integer
  attribute :date_tirage, :date
  attribute :beneficiaire_aleatoire, :boolean, default: false

  validates :tontine_id, presence: true
  validates :ordre, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :date_tirage, presence: true
  validates :ordre, uniqueness: { scope: :tontine_id, message: "doit être unique au sein de cette tontine" }
end