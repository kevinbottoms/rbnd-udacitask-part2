module Listable
  def format_description(description)
    "#{description}".ljust(25)
  end
  def format_priority(priority)
    value = " ⇧" if @priority == "high"
    value = " ⇨" if @priority == "medium"
    value = " ⇩" if @priority == "low"
    value = "" if !@priority
    raise UdaciListErrors::InvalidPriorityValue, "Priority Value Unsupported" if value != " ⇧" && value != " ⇨" && value != " ⇩" && value != ""
    return value
  end
  def format_date(*args)
    dates = @due.class == Date ? @due.strftime("%D") : @due
    dates = @start_date.strftime("%D") if @start_date
    dates << " -- " + @end_date.strftime("%D") if @end_date
    dates = "N/A" if !dates
    return dates
  end
end
