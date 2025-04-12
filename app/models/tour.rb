class Tour < ApplicationRecord
  belongs_to :tontine
  belongs_to :beneficiaire
end
