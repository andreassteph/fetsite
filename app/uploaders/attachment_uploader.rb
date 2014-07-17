# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
def root
  Rails.root.join 'public/'
end

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  def cover 
    manipulate! do |frame, index|
      index== 0 ? frame.convert(:jpg) : nil
      
    end
  end 
  version :thumb do
    process :cover
    process :resize_to_fill => [64, 64]

    def full_filename(for_file)
      super.chomp(File.extname(super)) + '.jpg'
    end 
  end
  version :cover do
    process :cover
    process :resize_to_fit => [64,64]
    process :convert => :jpg
    def full_filename(for_file)
      super.chomp(File.extname(super)) + '.jpg'
    end
  end
  version :thumb_small do
    process :resize_to_fill => [32, 32]
  end
  version :thumb_big do
    process :cover
    process :resize_to_fill => [200, 200]
    process :convert => :jpg
    def full_filename(for_file)
      super.chomp(File.extname(super)) + '.jpg'
    end 

  end
  version :resized do
    process :resize_to_fit => [1024,1024]
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
