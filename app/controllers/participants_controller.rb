class ParticipantsController < ApplicationController
    before_action :authenticate_personne!
    before_action :set_tontine
  
    def new
      @participant = @tontine.participants.new
      @page_slogan = "Rejoindre la tontine : #{@tontine.description}"
    end
  
    def create
      if @tontine.personnes.include?(current_personne)
        redirect_to tontine_path(@tontine), alert: 'Vous avez déjà rejoint cette tontine.'
        return
      end
  
      @participant = @tontine.participants.new(personne: current_personne, date_d_adhesion: Date.today)
  
      if @participant.save
        redirect_to tontine_path(@tontine), notice: 'Vous avez rejoint la tontine avec succès.'
      else
        render :new, status: :unprocessable_entity, alert: 'Erreur lors de l’inscription à la tontine.'
      end
    end
  
    def destroy
      @participant = Participant.find_by(personne: current_personne, tontine: @tontine)
      if @participant
        @participant.destroy
        redirect_to tontine_path(@tontine), notice: 'Vous avez quitté la tontine avec succès.'
      else
        redirect_to tontine_path(@tontine), alert: 'Vous n\'êtes pas membre de cette tontine.'
      end
    end
  
    private
  
    def set_tontine
      @tontine = Tontine.find(params[:tontine_id])
    end
  end