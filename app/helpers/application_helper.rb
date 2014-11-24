module ApplicationHelper
  include Mobvious::Rails::Helper

  def event_date date
    year = date.split("-")[0].to_i
    month = date.split("-")[1].to_i
    day = date.split("-")[2].to_i
    Date.new(year, month, day)
  end

  def event_time time
    hours = time.split(":")[0]
    minutes = time.split(":")[1]
    if hours.to_i > 12
      append = "PM" 
    else
      append = "AM"
    end
    (hours.to_i % 12).to_s << ":"<< minutes << " " << append
  end
end
