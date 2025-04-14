class ToursController < ApplicationController
    before_action :authenticate_personne!
    before_action :set_tontine
    before_action :set_tour, only: [:show, :edit, :update, :destroy, :tirer_beneficiaire]
    before_action :authorize_creator!, only: [:new, :create, :edit, :update, :destroy, :tirer_beneficiaire]
  
    def index
      @tours = @tontine.tours.order(:ordre)
    end
  
    def show
    end
  
    def new
        @tour = @tontine.tours.new
        @beneficiaires_possibles = @tontine.personnes # Récupérer les participants de la tontine comme bénéficiaires potentiels
        @tontine = Tontine.find(params[:tontine_id])
        dernier_tour = @tontine.tours.order(ordre: :desc).first
        @tour = @tontine.tours.build(ordre: dernier_tour.present? ? dernier_tour.ordre + 1 : 1)
    end
  
    def create
      @tour = @tontine.tours.new(tour_params)
      if @tour.save
        redirect_to tontine_tours_path(@tontine), notice: 'Le tour a été créé avec succès.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
    end
  
    def update
        # Gérer le cas où aucun bénéficiaire n'est sélectionné (paramètre vide)
        tour_params_with_nil_beneficiaire = tour_params
        tour_params_with_nil_beneficiaire[:beneficiaire_id] = nil if tour_params[:beneficiaire_id].blank?
      
        if @tour.update(tour_params_with_nil_beneficiaire)
          redirect_to tontine_tours_path(@tontine), notice: 'Le tour a été mis à jour avec succès.'
        else
          render :edit, status: :unprocessable_entity
        end
    end
  
    def destroy
      @tour.destroy
      redirect_to tontine_tours_path(@tontine), notice: 'Le tour a été supprimé avec succès.'
    end
  
    def tirer_beneficiaire
      personnes_participantes = @tontine.personnes.to_a
      if personnes_participantes.any? && @tour.beneficiaire.nil?
        beneficiaire = personnes_participantes.shuffle.first
        @tour.update(beneficiaire: beneficiaire)
        redirect_to tontine_tour_path(@tontine, @tour), notice: "Le bénéficiaire a été tiré au sort : #{beneficiaire.email}"
      else
        flash.alert = "Impossible de tirer un bénéficiaire : aucun participant ou bénéficiaire déjà désigné."
        redirect_to tontine_tour_path(@tontine, @tour)
      end
    end
  
    private
  
    def set_tontine
      @tontine = Tontine.find(params[:tontine_id])
    end
  
    def set_tour
      @tour = @tontine.tours.find(params[:id])
    end
  
    def tour_params
      params.require(:tour).permit(:ordre, :date_tirage, :beneficiaire_id)
    end
  
    def authorize_creator!
      unless @tontine.creator == current_personne
        redirect_to @tontine, alert: "Vous n'êtes pas autorisé à gérer les tours de cette tontine."
      end
    end
  end
