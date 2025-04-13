class Personne < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_tontines, class_name: 'Tontine', foreign_key: 'organisateur_id', dependent: :destroy
  has_many :administrateurs, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :tontines, through: :participants
  has_many :tours, foreign_key: 'beneficiaire_id', dependent: :nullify
  has_many :notifications, as: :utilisateur, dependent: :destroy

  validates :nom, presence: true
  validates :prenom, presence: true
  validates :email, presence: true, uniqueness: true
  validates :telephone, presence: true

  # Méthode pour obtenir le nom complet
  def nom_complet
    "#{prenom} #{nom}"
  end
end