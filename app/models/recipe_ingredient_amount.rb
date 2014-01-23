class RecipeIngredientAmount < ActiveRecord::Base
	# before_validation :set_ingredient_id
	belongs_to :ingredient_amount
	belongs_to :recipe
    validates :ingredient_amount_id, presence: true
	validates :ingredient_id, presence: true, uniqueness: { scope: :recipe_id,
    													message: "should only have one meal_recipe combo" }
	validates :recipe_id, presence: true, uniqueness: { scope: :ingredient_id,
    													message: "should only have one meal_recipe combo" }

    # private
    # 	def set_ingredient_id
    # 		self.ingredient_id = self.ingredient_amount.ingredient_id
    # 	end
end
