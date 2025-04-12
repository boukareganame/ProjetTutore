class Contribution < ApplicationRecord
  belongs_to :participant
  belongs_to :tontine
end
