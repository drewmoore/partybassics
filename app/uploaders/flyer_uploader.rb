# encoding: utf-8

class FlyerUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  version :landscape, :if => :is_landscape? do
    process :resize_to_fit => [800, 533]
    version :display do
      process :resize_to_fit => [500, 333]
    end
  end

  version :portrait, :if => :is_portrait? do
    process :resize_to_fit => [533, 800]
    version :display do
      process :resize_to_fit => [333, 500]
    end
  end

  def version_names
    versions.keys
  end

  def orientation
    if @orientation.nil?
      version_names.each do |version|
        @orientation = version if send("is_#{version}?")
      end
    end
    @orientation
  end

  def url_for(size)
    versions[orientation].send(size).url
  end

  protected

    def is_landscape?(*args)
      @picture = args.first
      image[:width] > image[:height]
    end

    def is_portrait?(*args)
      @picture = args.first
      image[:height] > image[:width]
    end

    def image
      # The definition of self depends on what is calling this method. If it
      # traces back to the CarrierWave config above, the picture must be passed
      # as an arg. Store as an instance global to avoid reloading on each method call.
      @picture ||= self
      # Store the image file as an instance global to avoid re-opening on
      # each method call.
      if @image_file.nil?
        # Is this a local temp file being prepared for s3 or is this from the bucket?
        if File.file?(@picture.path)
          image_path = Rails.root + @picture.path
        else
          image_path = @picture.url
        end
        @image_file = MiniMagick::Image.open(image_path)
      end
      @image_file
    end
end
