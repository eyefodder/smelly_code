require 'mathn'

class Recipe < ActiveRecord::Base
	has_many :recipe_ingredient_amounts, dependent: :destroy
	has_many :ingredient_amounts, through: :recipe_ingredient_amounts, dependent: :destroy
	# has_and_belongs_to_many :meals
	accepts_nested_attributes_for :ingredient_amounts, allow_destroy: true

	
	has_many :ingredients, through: :ingredient_amounts

	before_save { name.downcase!}
	validates :image_uri, presence: true
	validates :name, presence: true, uniqueness: {case_sensitive: false}
	validates :servings, presence: true, numericality: { only_integer: true }

	def shopping_list
		shopping_list_for servings
	end

	def add_ingredient!(ingredient, amount)
		begin
			ing_amt = IngredientAmount.create!(ingredient_id:ingredient.id, amount:amount)
			ria = recipe_ingredient_amounts.create!(ingredient_amount_id:ing_amt.id, ingredient_id: ing_amt.ingredient_id)
		rescue Exception
			if !ing_amt.nil?
				ing_amt.destroy!
			end
			raise
		end
	end

	def add_ingredient(ingredient, amount)
		begin
			add_ingredient!(ingredient, amount)
		rescue Exception
		end
	end

	def remove_ingredient!(ingredient)
		#nb removes ingredient amount, doesnt delete ingredient
		ingredient_amounts.find_by(ingredient_id:ingredient.id).destroy!
		recipe_ingredient_amounts.find_by(ingredient_id:ingredient.id).destroy!
	end

	def has_ingredient?(ingredient)
		ingredient_amount_for ingredient #will return 'truthy' values if not exactly true / false...
	end

	def ingredient_amount_for ingredient
		ingredient_amounts.find_by(ingredient_id:ingredient.id)
	end
	def recipe_ingredient_amount_for ingredient
		recipe_ingredient_amounts.find_by(ingredient_id:ingredient.id)
	end

  #returns a shopping list rounded to nearest .1 place
  def shopping_list_for(num_servings)
  	factor = num_servings / servings
  	arr = ingredient_amounts.map { |x| x.dup }

    # puts ("returning a list with factor #{factor} original: #{arr}")
    arr.each do |item|
    	item.amount = (item.amount * factor).round(1)
    end


    # puts ("result: #{arr}")
    ShoppingList.new(arr)
end
end
