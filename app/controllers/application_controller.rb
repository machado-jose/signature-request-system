class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :select_template

  def select_template
    params[:controller] == 'solicitations' ? 'application' : 'signature_template'
  end
end
