module ApplicationHelper
  include Mobvious::Rails::Helper

  def sin_plu(number, word)
    if number.to_f > 1.0 or number.to_f < 1.0
      return word << "s"
    else
      return word
    end
  end

end
