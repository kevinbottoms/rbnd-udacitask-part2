class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
    raise UdaciListErrors::InvalidItemType,
      "This type of item is not supported." if type != "todo" && type != "event" && type != "link"
  end
  def delete(index)
    raise UdaciListErrors::IndexExceedsListSize,
      "Item doesn't exist." if index > @items.length
    @items.delete_at(index - 1)
  end
  def clear_list
    counter = 0
    while counter < self.items.length
      self.items.delete_at(0)
    end
  end
  def all
    rows = []
    if !@title
      puts ""
    else
      puts @title
    end
    @items.each_with_index do |item, position|
      rows << ["#{position + 1}", "#{item.type}", "#{item.details}"]
      rows << :separator
    end
    table = Terminal::Table.new :rows => rows
    puts table
  end
  def filter(type)
    rows = []
    @items.each_with_index do |item, position|
      if item.type == type
        rows << ["#{position + 1}", "#{item.type}", "#{item.details}"]
        rows << :separator
      end
    end
    table = Terminal::Table.new :rows => rows
    puts table
  end
end
