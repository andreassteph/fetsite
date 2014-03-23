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
def get_theme
  if ThemesForRails.available_theme_names.include?(params[:theme])
  params[:theme]
 
else
"2003"
end
end
  def default_url_options
    {locale: I18n.locale, theme: theme_name, ansicht: nil}
  end
end
