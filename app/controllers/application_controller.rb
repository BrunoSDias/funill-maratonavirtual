class ApplicationController < ActionController::Base
  before_action  :authenticate_user!

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

end
