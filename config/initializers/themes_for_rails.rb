ThemesForRails.config do |config|
  #
  # If you have placed your themes like the example path above within the asset pipeline:
  config.themes_dir = 'app/assets/themes'
  config.assets_dir = 'app/assets/assets/themes/:name'
  config.views_dir = 'app/views/themes/:name'
  config.use_sass=true 
# ...
end
