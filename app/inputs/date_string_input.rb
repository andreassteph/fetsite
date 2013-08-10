class DateStringInput < FormtasticBootstrap::Inputs::StringInput
	def input_html_options
		super.merge(:class => "datetext", :onclick =>"beep", :value=>I18n.l(@object.send(method.to_sym)))
	end
	
end
