class PersonnesController < ApplicationController
    before_action :authenticate_personne!
    before_action :set_personne, only: [:show, :edit, :update, :destroy]
    before_action :authorize_admin!, only: [:index, :destroy] # Exemple d'autorisation admin
  
    def index
      @personnes = Personne.all
    end
  
    def show
    end
  
    def edit
      unless current_personne == @personne || current_personne&.administrateur
        redirect_to root_path, alert: "Vous n'êtes pas autorisé à modifier cet utilisateur."
      end
    end
  
    def update
      if current_personne == @personne || current_personne&.administrateur
        if @personne.update(personne_params)
          redirect_to @personne, notice: 'Votre profil a été mis à jour avec succès.'
        else
          render :edit, status: :unprocessable_entity
        end
      else
        redirect_to root_path, alert: "Vous n'êtes pas autorisé à modifier cet utilisateur."
      end
    end
  
    def destroy
      @personne.destroy
      redirect_to personnes_path, notice: 'L\'utilisateur a été supprimé avec succès.'
    end
  
    private
  
    def set_personne
      @personne = Personne.find(params[:id])
    end
  
    def personne_params
      params.require(:personne).permit(:nom, :prenom, :email, :telephone, :password, :password_confirmation)
    end
  
    def authorize_admin!
      unless current_personne&.administrateur
        redirect_to root_path, alert: "Vous n'avez pas les autorisations d'administrateur."
      end
    end
  end