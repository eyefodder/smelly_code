# == Schema Information
#
# Table name: ingredient_amounts
#
#  id            :integer          not null, primary key
#  amount        :decimal(5, 2)
#  ingredient_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class IngredientAmount < ActiveRecord::Base
  AMOUNT_COMPARISON_DELTA = 0.1
	belongs_to :ingredient 
	has_one :ingredient_scale , through: :ingredient
	validates :amount, presence: true
	

	validates :ingredient_id, presence: true
	# validates :recipe_id, presence: true, uniqueness: { scope: :ingredient_id,
 #    													message: "should only have one ingredient amount per recipe" }

  def same_ingredient_as?(other_ingredient_amount)
    # puts("test against #{other_ingredient_amount.inspect} #{other_ingredient_amount.nil?}")
    other_ingredient_amount && (ingredient_id == other_ingredient_amount.ingredient_id)
  end

  def same_ingredient_amount_as?(other_ingredient_amount)
    # (@actual - @expected).abs <= @tolerance
    #  ingredients are compared to nearest 0.1
    (same_ingredient_as? other_ingredient_amount) && (amount-other_ingredient_amount.amount).abs <= AMOUNT_COMPARISON_DELTA
  end

  def +(other)
    if !self.same_ingredient_as?(other)
      raise "You can't add two amounts of different ingredients together. Trying to add a #{other.ingredient} to a #{self.ingredient}"
    end
    result = self.dup
    result.amount += other.amount
    result
  end

  def ==(other)
    same_ingredient_amount_as? other
  end

  def <=>(other)
    name <=> other.name
  end


  def quantity_for_inspect (amount, first_word)
    if amount ==0.5
      # 'half an egg | Half a cucumber'
      ('aeiou'.include? first_word.chr) ? 'Half an' : 'Half a'
    elsif amount == 1
      # 'An egg | A cucumber'
     ('aeiou'.include? first_word.chr) ? 'An' : 'A'
    else
      # '2 eggs | 2.5 cucumbers'
      str = amount.to_s
      str.slice!('.0') # turns '2.0' into '2' but retains '2.5' making this more readable
      str
    end
  end

  def inspect
    if(ingredient.nil?)
      super
    else
      first_word = ingredient_scale.nil? ? ingredient.name : ingredient.scale_name
      quantity = quantity_for_inspect(amount, first_word)
      second_word = ingredient_scale.nil? ? '' : "of #{ingredient.name}"
      if amount > 1 
        first_word = first_word.pluralize
      end
      
      "#{quantity} #{first_word} #{second_word}".squish
    end
  end

  def name
    ingredient.name
  end

end
