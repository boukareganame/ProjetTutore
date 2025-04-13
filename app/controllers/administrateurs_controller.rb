class AdministrateursController < ApplicationController
    before_action :authenticate_personne!
    before_action :authorize_admin!
    before_action :set_administrateur, only: [:show, :destroy]
  
    def index
      @administrateurs = Administrateur.all
    end
  
    def new
      @administrateur = Administrateur.new
      @personnes = Personne.where.not(id: Administrateur.pluck(:personne_id)) # Afficher les personnes non admin
    end
  
    def create
      @administrateur = Administrateur.new(administrateur_params)
      if @administrateur.save
        redirect_to administrateurs_path, notice: 'L\'administrateur a été créé avec succès.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def show
    end
  
    def destroy
      @administrateur.destroy
      redirect_to administrateurs_path, notice: 'L\'administrateur a été supprimé avec succès.'
    end
  
    private
  
    def set_administrateur
      @administrateur = Administrateur.find(params[:id])
    end
  
    def administrateur_params
      params.require(:administrateur).permit(:personne_id)
    end
  
    def authorize_admin!
      unless current_personne&.administrateur
        redirect_to root_path, alert: "Vous n'avez pas les autorisations d'administrateur."
      end
    end
  end