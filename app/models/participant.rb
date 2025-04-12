class Participant < ApplicationRecord
  belongs_to :personne
  belongs_to :tontine
end
