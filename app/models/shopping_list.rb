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


  def grouped_list
    arr = @items.sort do |x,y|
      x.ingredient.ingredient_location_group.name <=> y.ingredient.ingredient_location_group.name
    end
    result = []
    last_item = arr[0]
    if (last_item)
      current_group = create_group last_item
      result.push(current_group)
      i = 1
      while(i<arr.length) do
        next_item = arr[i]
        if next_item.ingredient.ingredient_location_group != last_item.ingredient.ingredient_location_group
          current_group = create_group next_item
          result.push(current_group)
        else
          current_group[:items].push(next_item)
        end
        last_item = next_item
        i += 1
      end
    end

    result
  end

  def create_group ingredient_amount
   group = {group: ingredient_amount.ingredient.ingredient_location_group, items: [ingredient_amount]}
   group
 end

 def +(otherlist)
    # puts("combining #{self.inspect} with #{otherlist.inspect}")
    result = @items + otherlist.items
    result.sort!
    i = 1
    while (i<result.length) do
      # puts ("seeing if #{result[i].inspect} is same ingredient as #{result[i-1].inspect}, i: #{i}, #{result[i].same_ingredient_as? result[i-1]}")
      if result[i].same_ingredient_as? result[i-1]
       result [i-1] += result [i] 
       result.slice!(i)
     else
      i += 1
    end
  end
  ShoppingList.new(result)
end

end