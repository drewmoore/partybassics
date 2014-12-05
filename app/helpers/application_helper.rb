module ApplicationHelper
  include Mobvious::Rails::Helper

  def sin_plu(number, word)
    if number.to_f > 1.0 or number.to_f < 1.0
      return word << "s"
    else
      return word
    end
  end

  def flyer(event, size)
    if File.exists? event.flyer.versions[:portrait].path
      return asset_path(event.flyer.versions[:portrait].send(size))
    elsif File.exists? event.flyer.versions[:landscape].path
      return asset_path(event.flyer.versions[:landscape].send(size))
    end
  end

end
