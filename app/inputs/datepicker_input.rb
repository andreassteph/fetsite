class DatepickerInput < FormtasticBootstrap::Inputs::StringInput
	def input_html_options
		super.merge(:class => "input-append date")
	end
	def html_options
		super.merge(:default => Date.today)
	end
	def wrapper_html_options
		super.merge(:class=>"datepicker",'date-date-format'.to_sym=>"%d.%m.%Y")
	end
	def controls_wrapper_html_options
		super.merge(:class=> "controls", 'date-date'.to_sym =>Time.now.to_date.to_s)
	end
	#def to_html
	#	bootstrap_wrapping do
     #       builder.text_field(method, input_html_options)
	#	end
	#end
	def options
		super#d.merge(:class=>"datepicker")
		#super.merge(:append_content=>'<span class="add-on input-append"
		#super.merge(:append_content=>'<span class="add-on" ><i class="icon-th"></i></span>')
	end
end
