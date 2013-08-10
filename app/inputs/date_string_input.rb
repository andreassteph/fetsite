class DateStringInput < FormtasticBootstrap::Inputs::StringInput
	def input_html_options
		value = (@object.send(method.to_sym))
		super.merge(:class => "datetext", :onclick =>"beep", :value=>I18n.l((value.is_a?(Time)||value.is_a?(Date)||value.is_a?(DateTime)) ? value : Time.now))
	end
	
end
