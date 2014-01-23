class MainPagesController < ApplicationController
  def home
  	@title = 'Smelly Code'
  	@recipes = Recipe.all
  	@shopping_list = ShoppingList.new([])
  	@chosen_recipes = []

  end

  def make_list
  	@title = 'Smelly Code'
  	@recipes = Recipe.all
  	if params[:shopping_list_recipes]
  		@chosen_recipes = Recipe.find(params[:shopping_list_recipes].keys)
  		@shopping_list = ShoppingList.new([])
  		@chosen_recipes.each do |recipe|
  			@shopping_list += recipe.shopping_list
  		end
  	else
  		@chosen_recipes = []
  		@shopping_list = ShoppingList.new([])
  	end
  	render 'home'
  end
end
