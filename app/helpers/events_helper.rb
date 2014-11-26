module EventsHelper
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

  def google_map_query(street, zip)
    new_street = street.gsub(" ", "+")
    return new_street << "," << zip
  end

  def in_future? event
    year = event.date.split("-")[0].to_i
    month = event.date.split("-")[1].to_i
    day = event.date.split("-")[2].to_i
    if DateTime.now.year < year
      return true
    elsif DateTime.now.year == year and DateTime.now.month < month
      return true
    elsif DateTime.now.year == year and DateTime.now.month == month and DateTime.now.day <= day
      return true
    else
      return false
    end
  end
end
