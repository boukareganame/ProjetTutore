# app/controllers/home_controller.rb
class HomeController < ApplicationController
  include Devise::Controllers::Helpers

  def index
    if personne_signed_in?
      # Redirect logged-in users to their dashboard or main application page
      redirect_to tontines_path # Or whatever your main page is
    else
      # Render a page with login and registration options
      render 'home/index'
    end
  end
end
