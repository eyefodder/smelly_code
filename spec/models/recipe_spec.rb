# == Schema Information
#
# Table name: recipes
#
#  id         :integer          not null, primary key
#  image_uri  :string(255)
#  name       :string(255)
#  servings   :integer
#  created_at :datetime
#  updated_at :datetime
#
require 'mathn'
require 'spec_helper'

describe Recipe do


  before do
  	@item = Recipe.new(	image_uri:'http://barnesandhoggetts.com/wp-content/uploads/2013/11/20131112-P1060175-1024x1024.jpg',
      name: 'Hot Pickled Herring',
      servings: 2)
  end

  after do
    @item.destroy
  end
  subject {@item}

  describe 'basic api' do

    it { should be_accessible :name, :image_uri, :servings, :ingredient_amounts, :add_ingredient!, :ingredients}
    it { should validate_presence :name, :image_uri, :servings}
    it { should validate_integer :servings}
    it { should have_unique_case_insensitive :name}
  end

  describe 'generating a shopping list' do
    let(:scale) {FactoryGirl.create(:ingredient_scale)}
    let(:gin) {FactoryGirl.create(:ingredient, name: "gin", ingredient_scale_id: scale.id)}
    let(:tonic) {FactoryGirl.create(:ingredient, name: "tonic", ingredient_scale_id: scale.id)}
    let(:eggs) {FactoryGirl.create(:ingredient, name: "eggs", ingredient_scale_id: scale.id)}
    let(:servings){2}
    let(:amount){1.2}

    let(:recipe) {FactoryGirl.create(:recipe, name:"gin and tonic", servings: servings)}

    subject{recipe}

    it 'returns an empty list if no ingredients' do
      expect(recipe.shopping_list_for servings).to be_empty
    end
    it 'returns a shopping list' do
      expect(recipe.shopping_list_for servings).to be_a ShoppingList
    end

    it 'returns a list containing the same ingredients as the recipe' do
      recipe.add_ingredient!(gin,amount)
      list = recipe.shopping_list_for servings
      expect(list.length).to eq 1
      expect(list).to include_ingredient_amount(gin, amount)
    end

    it 'scales the list to the number of servings' do
      recipe.add_ingredient!(gin,amount)
      list = recipe.shopping_list_for servings*2
      expect(list).to include_ingredient_amount(gin, amount*2)
    end

    it 'also scales the list with fewer servings' do
      recipe.add_ingredient!(gin,amount)
      list = recipe.shopping_list_for (servings / 3.0)
      expect(list).to include_ingredient_amount(gin, amount/3.0)
    end

    it 'works if you change the recipe servings after the fact' do
      recipe.add_ingredient!(gin,amount)
      recipe.servings *= 2
      list = recipe.shopping_list_for servings*2
      expect(list).to include_ingredient_amount(gin, amount)

    end
    
  end


  context 'adding and removing' do
    let(:ingredient) {FactoryGirl.create(:ingredient)}
    let(:ingredient2) {FactoryGirl.create(:ingredient)}
    let(:amt){3}
    before do
      @item.save
      @item.add_ingredient! ingredient, amt
    end
    describe "adding an ingredient" do

      it 'returns true for has_ingredient' do
        expect(@item.has_ingredient? ingredient).to be_true
      end

      it 'returns ingredient_amount for ingredient' do
        result = @item.ingredient_amount_for ingredient
        expect(result).to_not be_nil
        expect(result.ingredient_id).to eq ingredient.id
        expect(result.amount).to eq amt
      end
      it 'returns recipe_ingredient_amount for ingredient' do
        result = @item.recipe_ingredient_amount_for ingredient
        expect(result).to_not be_nil
      end

      it 'will let you find the ingredient in .ingredients' do
        @item.ingredients.should include(ingredient)
      end

      it "will throw an error if attempting to add the same ingredient" do
        expect {@item.add_ingredient! ingredient, amt}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'increments the number of ingredient_amounts' do
        expect {@item.add_ingredient! ingredient2, amt}.to change{@item.ingredient_amounts.count}.by(1)
      end
      it 'increments the number of ingredients' do
        expect {@item.add_ingredient! ingredient2, amt}.to change{@item.ingredients.count}.by(1)
      end
      it 'increments the number of recipe_ingredient_amounts' do
        expect {@item.add_ingredient! ingredient2, amt}.to change{@item.recipe_ingredient_amounts.count}.by(1)
      end

      it 'will not throw an error when using non bang method' do
        expect {@item.add_ingredient ingredient, amt}.to_not raise_error
      end

    end
    describe 'removing an ingredient' do

      it 'removes the ingredient from the list' do
        @item.remove_ingredient!(ingredient)
        @item.ingredients.should_not include(ingredient)
      end

      it 'no longer has_ingredient' do
         @item.remove_ingredient!(ingredient)
         expect(@item.has_ingredient? ingredient).to be_false
      end

      it 'decrements the number of ingredient_amounts' do
        expect {@item.remove_ingredient!(ingredient)}.to change{@item.ingredient_amounts.count}.by(-1)
      end
      it 'decrements the number of ingredients' do
        expect {@item.remove_ingredient!(ingredient)}.to change{@item.ingredients.count}.by(-1)
      end
      it 'increments the number of recipe_ingredient_amounts' do
        expect {@item.remove_ingredient!(ingredient)}.to change{@item.recipe_ingredient_amounts.count}.by(-1)
      end
      context 'database checks' do
        let!(:ingredient_amount){@item.ingredient_amount_for ingredient}
        let!(:recipe_ingredient_amount){@item.recipe_ingredient_amount_for ingredient}

        before do
          @item.remove_ingredient!(ingredient)
        end
        it 'deletes the ingredient_amount from the DB' do
          expect(IngredientAmount.where(id: ingredient_amount.id)).to be_empty
        end
        it 'deletes the recipe_ingredient_amounts form the DB' do
          expect(RecipeIngredientAmount.where(id: recipe_ingredient_amount.id)).to be_empty
        end

      end
      
    end
  end
  
  
end
