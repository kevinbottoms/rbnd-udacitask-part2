module Listable
  def format_description(description)
    "#{description}".ljust(25)
  end
  def format_priority(priority)
    value = " ⇧".colorize(:red) if @priority == "high"
    value = " ⇨".colorize(:yellow) if @priority == "medium"
    value = " ⇩".colorize(:green) if @priority == "low"
    value = "" if !@priority
    raise UdaciListErrors::InvalidPriorityValue, "Priority Value Unsupported" if value != " ⇧".colorize(:red) && value != " ⇨".colorize(:yellow) && value != " ⇩".colorize(:green) && value != ""
    return value
  end
  def format_date(*args)
    dates = Chronic.parse(@due).strftime('%H:%M %d %b %Y') if @due
    #dates = @due.class == Date ? @due.strftime("%D") : Chronic.parse('{@due}')
    dates = @start_date.strftime("%D") if @start_date
    dates << " -- " + @end_date.strftime("%D") if @end_date
    dates = "N/A" if !dates
    return dates
  end
end
