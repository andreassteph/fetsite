module ApplicationHelper
  def cache_array_key(array)
    array.map{|c| c.id}.join('')+"_"+array.max{|c|c.updated_at.to_i}.updated_at.to_i.to_s+"_"+I18n.locale.to_s
  end

  def clean_calendar(cal)
    cal.rubrik.meetingtyps.each do |mt| 
      mt.meetings.each do |m|
        m.calentry.calendar=cal
      end
    end
  end
  def strip_control_chars(value)
    value.chars.inject("") do |str, char|
      unless char.ascii_only? && (char.ord < 32 || char.ord == 127)
        str << char
      end
       str
    end
  end
  def convert_topic_to_meeting(t,mt)
    m=Meeting.new_with_date_and_typ(t,t.title.to_date+16.hour,mt)
    m.save
    m.create_protocol
    m.protocol.text=t.text
    m.protocol.save
    m.update_time_from_protocol
m.save

    t.meetings << m
    t.save
  end
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
  def absurl(path)
     if path.nil?
       return nil
     end
    url=URI(root_url)
    url.path=path
    return url
  end
end
