# == Schema Information
#
# Table name: recipe_ingredient_amounts
#
#  id                   :integer          not null, primary key
#  recipe_id            :integer
#  ingredient_amount_id :integer
#  created_at           :datetime
#  updated_at           :datetime
#  ingredient_id        :integer
#

require 'spec_helper'

describe RecipeIngredientAmount do
  let(:ing_amt) {FactoryGirl.create(:ingredient_amount)}
  let(:recipe) {FactoryGirl.create(:recipe)}
  let!(:recipe_amount) {recipe.recipe_ingredient_amounts.create!(ingredient_amount_id:ing_amt.id, ingredient_id:ing_amt.ingredient_id)}

  subject {recipe_amount}

  describe 'basic api' do
    it { should be_accessible :ingredient_amount, :recipe}
    it { should validate_presence :ingredient_amount_id, :recipe_id, :ingredient_id}
  end

  describe 'associations' do
    it 'returns meal set by meal_id' do
      recipe_amount.ingredient_amount.should eq ing_amt
    end
    it 'returns recipe set by recipe_id' do
      recipe_amount.recipe.should eq recipe
    end
  end

  describe 'uniqueness' do
    let!(:new_ing_amt) {ing_amt.dup}
    before do
      new_ing_amt.save!
    end
    after do
     new_ing_amt.destroy
   end


   it 'should have unique recipe ingredient combinations' do
    new_recipe_amt = RecipeIngredientAmount.new(recipe_id:recipe.id, ingredient_amount_id:new_ing_amt.id, ingredient_id:new_ing_amt.ingredient_id)
    expect(new_recipe_amt).to_not be_valid
  end
end
end