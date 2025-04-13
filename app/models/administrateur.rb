class Administrateur < ApplicationRecord
  belongs_to :personne

  validates :personne_id, presence: true, uniqueness: true
end