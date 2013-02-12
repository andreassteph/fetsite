module ApplicationHelper
  def current_url(overwrite={})
    url_for :only_path => true, :params => params.merge(overwrite).except(:controller,:action)
  end
  def switch_locale_url(target_locale)
    current_url({:locale=>target_locale}) .sub "/"+I18n.locale.to_s+"/", "/"+target_locale.to_s+"/"
   
  end

end
