module ApplicationHelper
  def current_url(overwrite={})
    url_for  :params => params.merge(overwrite).except(:controller,:action)
  end
  def switch_locale_url(target_locale)
    current_url({:locale=>target_locale}) .sub "/"+I18n.locale.to_s+"/", "/"+target_locale.to_s+"/"
   
  end
  def toolbar_html(elemente)
    html = ""
    	elemente.each do |e| 
	html =html + e + " | "
	end 
    #html= html + "</ul>"
    raw(html)
  end
end
