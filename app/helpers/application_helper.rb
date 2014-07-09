module ApplicationHelper
 def current_url1(overwrite={})
     url_for  :params => params.merge(overwrite).except(:controller,:action,:ansicht)
 end


  def switch_locale_url(target_locale)
    current_url1({:locale=>target_locale}) .sub "/"+I18n.locale.to_s+"/", "/"+target_locale.to_s+"/"
   
  end
  def ffi1_icon (name)
    content_tag("i","", class: "ffi1-"+name )
  end
  def ff_icon (name)
    content_tag("i","", class: name )
  end

  def ffi1_list 
    y=YAML.load_file("#{::Rails.root.to_s}/config/flatfeticon1.yml")
    y["ffi1"]
end

  def tinymce_icon_choice 
    s=""
    ffi1_list.each do |i| 
      s=s+'<a onclick="insertIcon_ffi1(\'ffi1-'+i+'\')">'+ffi1_icon(i)+'</a>' 
    end
    raw(s)
  end

  def toolbar_html(elemente)
    html = ""
    limiter = " | "
 	elemente.each do |e| 
		if !e[:icon].nil?
			case e[:icon]
			when :pencil
			text = '<i class="icon-pencil"></i>'.html_safe + e[:text]
			when :plus
			text ='<i class="icon-plus"></i>'.html_safe+e[:text]
			else
			text = e[:text]
			end
		else
			text =e[:text]
		end
        	if e[:link].nil? 
		if !e[:method].nil?
			if !e[:confirm].nil?
			html = html + link_to(text,e[:path],:confirm=>e[:confirm],:method=>e[:method])
			else
			html = html + link_to(text,e[:path],:method => e[:method])
			end
		else
			if !e[:confirm].nil?
			html=html + link_to(text,e[:path],:confirm=>e[:confirm])
			else
			html= html + link_to(text,e[:path])
			end

		end 
		else
		html = html + e[:link]
		end
		
    		html=html+limiter
	end
    raw(html)
 end
end
