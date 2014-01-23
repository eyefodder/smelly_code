#require 'spec_helper'
# module Matchers
# 	class HaveAttributes
# 		def matches?(item)
# 			@item = item
# 			expect(@item).to respond_to(:name)
# 		end

# 		def failure_message
# 			"expected to respond to name"
# 		end

# 		def negative_failure_message
# 			"expected not to respond to name"
# 		end
# 	end

# 	def have_attributes
# 		HaveAttributes.new
# 	end

# 	alias :have_the_attributes :have_attributes

# end

# RSpec::Matchers.define :have_attributes do |attribute|
# 	match do |model|
# 		expect(model).to respond_to(attribute)
# 	end

# 	failure_message
# end
#
RSpec::Matchers.define :include_ingredient_amount do |ingredient, amount|
  match do |response|

    expected = IngredientAmount.new(amount: amount, ingredient_id:ingredient.id)
    description { "have an entry for #{expected.inspect}" }
    failure_message_for_should { "Expecting to find #{expected.inspect} in #{response.inspect}" }
    failure_message_for_should_not { "#{expected.inspect} should not be in the list but was found" }
    result = false
    response.each do |ingredient_amount|
      if ingredient_amount == expected then
        result = true
        break
      end
    end
    result
  end
end
RSpec::Matchers.define :include_menu_purchase do |menu, ingredient, amount, purchased_ingredient=nil, purchased_amount=nil, supplier=nil, cost_cents=nil|
  match do |response|
    ingredient_amount = IngredientAmount.new(amount: amount, ingredient_id:ingredient.id)
    # expected = Purchase.create_from_menu_ingredient_amount(menu.purchase_list, ingredient_amount)

    # expected = {purchase_list: menu.purchase_list, supplier: supplier, list_ingredient_amount: ingredient_amount, purchase_ingredient_amount: ingredient_amount.dup, price_dollars:cost_cents.to_f/100}

    description { "have an purchase for #{expected.inspect}" }
    failure_message_for_should { "Expecting to find list:#{ingredient_amount.inspect}\n in \n #{response.inspect}" }
    failure_message_for_should_not { "#{ingredient_amount.inspect} should not be in the list but was found" }
    result = false
    response.each do |purchase|
      # other_purchase.purchase_list == purchase_list  && other_purchase.list_ingredient_amount == list_ingredient_amount
      if (purchase.purchase_list==menu.purchase_list) && (purchase.list_ingredient_amount==ingredient_amount ) then
        if purchased_ingredient
          # we are testing against full deets
          # expected.purchase_ingredient_amount.ingredient = purchased_ingredient
          # expected.purchase_ingredient_amount.amount = purchased_amount
          # expected.supplier = supplier
          # expected.cost_cents = cost_cents
          purchase_ingredient_amount = IngredientAmount.new(amount: purchased_amount, ingredient_id:purchased_ingredient.id)
          result = (purchase.purchase_ingredient_amount == purchase_ingredient_amount) && purchase.supplier == supplier && purchase.cost_dollars = cost_cents.to_f/100
        else 
          # expected.purchase_ingredient_amount.ingredient = ingredient
          # expected.purchase_ingredient_amount.amount = amount
          result = true
        end
        # result = (purchase == expected)
      

        # (purchase_list==other.purchase_list )&& 
        # (supplier==other.supplier) && 
        # (list_ingredient_amount== other.list_ingredient_amount) &&
        # (purchase_ingredient_amount==other.purchase_ingredient_amount) &&
        # (price_dollars==other.price_dollars)
 

        # puts purchase.inspect
        # puts expected.inspect
        # puts "cents : purchasE; #{purchase.cost_cents}, #{purchase.cost_cents.nil?} expect; #{expected.cost_cents}"
        # puts ("(menu==other.menu #{purchase.menu==expected.menu})&& (supplier==other.supplier #{purchase.supplier == expected.supplier}) 
        #   && (list_ingredient_amount== other.list_ingredient_amount #{purchase.list_ingredient_amount == expected.list_ingredient_amount}) 
        #   &&(purchase_ingredient_amount==other.purchase_ingredient_amount #{purchase.purchase_ingredient_amount == expected.purchase_ingredient_amount}) 
        #   &&(cost_cents==other.cost_cents) #{purchase.cost_cents == expected.cost_cents}")
        # puts ("smae same_menu_ingredient_amount but does it match? #{result}")
        if result
          break
        end
      end
    end
    result
  end
end

RSpec::Matchers.define :be_accessible do |*attributes|
	match do |response|

		description { "have the following accessible attributes: #{attributes.inspect}" }

		attributes.each do |attribute|
			failure_message_for_should { "#{attribute} should be accessible" }
			failure_message_for_should_not { "#{attribute} should not be accessible" }

			break false unless response.respond_to?(attribute.to_s)
		end
	end
end

RSpec::Matchers.define :validate_presence do |*attributes|
	match do |response|

		description { "validate for presence of #{attributes.inspect}" }

    #not using should in matcher as it screws with description
		#response.should be_valid
    if response.valid?

      attributes.each do |attribute|
        failure_message_for_should { "#{attribute} should be required to be present" }
        failure_message_for_should_not { "#{attribute} should not be required to be present" }
        before_val = response[attribute]
        response[attribute] = "  " #adding whitespace to ensure that this fails (as it should)
        #response.should_not be_valid
        break false unless !response.valid?
        response[attribute] = before_val
      end
    else
      failure_message_for_should { "#{response.inspect} should be valid prior to testing validation" }
      false
    end
  end
end


RSpec::Matchers.define :validate_integer do |*attributes|
  match do |response|

    description { "validate that  #{attributes.inspect} must be integers" }

    #not using should in matcher as it screws with description
    #response.should be_valid
    if response.valid?

      attributes.each do |attribute|
        failure_message_for_should { "#{attribute} should be required to be integer" }
        failure_message_for_should_not { "#{attribute} should not be required to be integer" }
        before_val = response[attribute]
        response[attribute] = 2.3 #a number but not an integer
        #response.should_not be_valid
        break false unless !response.valid?
        response[attribute] = before_val
      end
    else
      failure_message_for_should { "#{response.inspect} should be valid prior to testing validation" }
      false
    end
  end
end


RSpec::Matchers.define :have_unique do |attribute|
	match do |response|

		description { "have a unique #{attribute.inspect}" }

		failure_message_for_should do
			"#{attribute} should be required to be unique
			original: #{response[attribute]}, attempted to save with #{@duplicate_item[attribute]}
			original valid: #{response.valid?} duplicate: #{@duplicate_item.valid?}" 
		end
		failure_message_for_should_not { "#{attribute} should not be required to be unique" }

		@duplicate_item  = response.dup
		@duplicate_item.save
		!response.valid? # using this syntax as should_not be_valid seemed to not work?!
	end
end
RSpec::Matchers.define :have_unique_case_insensitive do |attribute|
	match do |response|

		description { "have unique #{attribute.inspect} regardless of case" }

		failure_message_for_should do
			@failure_message || "#{attribute} should be required to be unique despite case " 
		end
		failure_message_for_should_not { "#{attribute} should not be required to be unique" }

		# first test it's saved in db all lowercase
		@mixed_case = "Foo@ExAMPle.CoM"
		response[attribute] = @mixed_case
		response.save
		response.reload # gets value from db
		newval = response[attribute]
		if response.reload[attribute] != @mixed_case.downcase
			@failure_message = "You aren't saving to DB in lowercase, try adding the folowing:\n 
      before_save { #{attribute}.downcase!}\n"
      false
    else
     @duplicate_item = response.dup
     @duplicate_item[attribute] = response[attribute].upcase
     !@duplicate_item.valid?
   end
 end
end