class DatepickerInput < FormtasticBootstrap::Inputs::StringInput
	def input_html_options
		super.merge(:class => "datepicker")
	end
	
end
