class ApplicationController < ActionController::Base
  before_action  :authenticate_user!
  before_action :add_www_subdomain

  def authenticate_user!
    if request.path_parameters[:format] != 'json'
      if cookies[:funil_admin].blank?
        redirect_to "/login"
      end
    end
  end

  def administrador
    if cookies[:funil_admin].present?
      return @adm if @adm.present?
      @adm = Administrador.find(JSON.parse(cookies[:funil_admin])["id"])
      return @adm
    end
  end

  def add_www_subdomain
    headers['Cache-Control'] = 'max-age=180, public'

    if Rails.env == "production"
      if /^http:/.match(request.original_url)
        redirect_to(request.original_url.gsub("http:", "https:"), :status => 301)
      elsif /herokuapp/.match(request.original_url)
        redirect_to(request.original_url.gsub("https://funil-99run.herokuapp.com", "https://funil.99run.com"), :status => 301)
      end
    end
  end
end
