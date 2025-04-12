class TontinesController < ApplicationController
  before_action :authenticate_personne! # Assurez-vous que l'utilisateur est connecté
  before_action :set_tontine, only: [:show, :edit, :update, :destroy]
  before_action :authorize_creator!, only: [:edit, :update, :destroy]

  def index
    @tontines = Tontine.all

    # Filtrage (la logique de votre filtre reste la même)
    if params[:frequence].present?
      @tontines = @tontines.where(frequence: params[:frequence])
    end
    if params[:montant_min].present?
      @tontines = @tontines.where('montant >= ?', params[:montant_min])
    end

    # Préparation des données pour les graphiques
    @tontines_par_frequence = @tontines.group(:frequence).count
    if Tontine.column_names.include?('created_at')
      @montants_par_date = @tontines.group_by_day(:created_at).sum(:montant)
    end
  end

  def show
    @tontine = Tontine.find(params[:id])
  end

  def new
    @tontine = Tontine.new
    @page_slogan = "Créer une nouvelle Tontine"
  end
  def create
    @tontine = current_personne.created_tontines.new(tontine_params)
    if @tontine.save
      # Ajouter automatiquement le créateur comme participant (MODIFIÉ)
      Participant.create(personne: current_personne, tontine: @tontine, date_d_adhesion: Date.today)
      redirect_to @tontine, notice: 'Tontine créée avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @tontine = Tontine.find(params[:id])
  end

  def update
    if @tontine.update(tontine_params)
      redirect_to @tontine, notice: 'La tontine a été mise à jour avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tontine.destroy
    redirect_to tontines_path, notice: 'La tontine a été supprimée avec succès.'
  end
  def set_page_slogan
    @page_slogan = "TontinesFaso!" # Slogan par défaut
  end
  
  def set_tontine
    @tontine = Tontine.find(params[:id])
  end


  private

  def tontine_params
    params.require(:tontine).permit(:description, :frequence, :montant)
  end
  def authorize_creator!
    unless @tontine.creator == current_personne
      redirect_to @tontine, alert: "Vous n'êtes pas autorisé à modifier cette tontine."
    end
  end
end

