class ShoppingList
  def initialize(arr)
    @items = arr
  end

  def method_missing(method_name, *args, &block)
    @items.send(method_name, *args, &block)

  end

  def items
    @items
  end

  def items=(other)
    @items = other
  end

  def inspect
    @items.inspect
  end



  def add_to(otherlist)
    result = []
    @items.each do |item|
      result << item
    end
    otherlist.items.each do |other_item|
      match = false
      @items.each do |original_item| 
        if original_item.ingredient == other_item.ingredient
          result_index = result.index {|item| item.ingredient == original_item.ingredient}
          result[result_index].amount += other_item.amount
          match = true
        end
      end
      result << other_item
    end
    ShoppingList.new(result)
  end

end