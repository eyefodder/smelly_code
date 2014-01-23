# == Schema Information
#
# Table name: ingredients
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  ingredient_scale_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

require 'spec_helper'

describe Ingredient do
  let (:scale) { FactoryGirl.create(:ingredient_scale) }

  before do
    # @item = Ingredient.new(name: "Garlic", scale_id:scale.id)
    #@item = scale.ingredients.build(name:"Garlic")
    @item = Ingredient.new(name:"Garlic", ingredient_scale_id: scale.id)
  end
  after do
    @item.destroy
  end

  subject { @item }

  describe 'basic api' do

    it { should be_accessible :name, :ingredient_scale_id, :ingredient_scale, :scale_name }
    it { should validate_presence :name }
    it { should have_unique_case_insensitive :name }
  end

 

  describe "scale associations" do
    before { @item.save }

    it 'should return the ingredient scale associated with it' do

      @item.ingredient_scale.should eq scale
    end


    it "should not destroy associated ingredient scale on destroy" do
      scale = @item.ingredient_scale
      @item.destroy
      expect(IngredientScale.where(id: scale.id)).to_not be_empty
    end
  end


end
