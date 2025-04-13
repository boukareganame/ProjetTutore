class ContributionsController < ApplicationController
    before_action :authenticate_personne!
    before_action :set_tontine
    before_action :set_tour
    before_action :set_contribution, only: [:edit, :update, :destroy]
    before_action :authorize_participant!, only: [:new, :create]
    before_action :authorize_contribution_owner!, only: [:edit, :update, :destroy]
  
    def new
      @participant = Participant.find_by(personne: current_personne, tontine: @tontine)
      if @participant
        @contribution = @tour.contributions.new(participant: @participant)
      else
        redirect_to @tontine, alert: "Vous devez être participant à cette tontine pour contribuer."
      end
    end
  
    def create
      @participant = Participant.find_by(personne: current_personne, tontine: @tontine)
      if @participant
        @contribution = @tour.contributions.new(contribution_params.merge(participant: @participant))
        if @contribution.save
          redirect_to tontine_tour_path(@tontine, @tour), notice: 'Votre contribution a été enregistrée.'
        else
          render :new, status: :unprocessable_entity
        end
      else
        redirect_to @tontine, alert: "Vous devez être participant à cette tontine pour contribuer."
      end
    end
  
    def edit
    end
  
    def update
      if @contribution.update(contribution_params)
        redirect_to tontine_tour_path(@tontine, @tour), notice: 'Votre contribution a été mise à jour.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_tontine
      @tontine = Tontine.find(params[:tontine_id])
    end
  
    def set_tour
      @tour = @tontine.tours.find(params[:tour_id])
    end
  
    def set_contribution
      @contribution = @tour.contributions.find(params[:id])
    end
  
    def contribution_params
      params.require(:contribution).permit(:montant)
    end
  
    def authorize_participant!
      unless Participant.exists?(personne: current_personne, tontine: @tontine)
        redirect_to @tontine, alert: "Vous n'êtes pas autorisé à contribuer à cette tontine."
      end
    end
  
    def authorize_contribution_owner!
      unless @contribution.participant&.personne == current_personne
        redirect_to tontine_tour_path(@tontine, @tour), alert: "Vous n'êtes pas autorisé à modifier cette contribution."
      end
    end
  end