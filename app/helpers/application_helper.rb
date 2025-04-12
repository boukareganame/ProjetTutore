module ApplicationHelper
  include Devise::Controllers::Helpers if defined?(Devise)

  def current_user
    warden.user if defined?(warden) && warden.authenticated?
  end

  private

  def warden
    request.env['warden']
  end
end
