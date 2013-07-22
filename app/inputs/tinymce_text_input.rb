class TinymceTextInput < FormtasticBootstrap::Inputs::TextInput
	def input_html_options
		super.merge(:class => "tinymce")
	end
end
