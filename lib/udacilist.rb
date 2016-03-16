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
  def all
    if !@title
      puts "-" * 18
    else
      puts "-" * @title.length
      puts @title
      puts "-" * @title.length
    end
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
