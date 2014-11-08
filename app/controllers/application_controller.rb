 class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_i18n_locale_from_params
  protected
  theme :get_theme 
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale=params[:locale].to_sym
      else
        flash.now[:notice]= "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_path(:only_path => false, :protocol => 'http')
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end
def get_theme
  if ThemesForRails.available_theme_names.include?(params[:theme])
  params[:theme]
 
else
"blue1"
end
end
  def default_url_options
    {locale: I18n.locale, theme: theme_name, ansicht: nil}
  end
end
