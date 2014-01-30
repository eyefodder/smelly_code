require 'spec_helper'

describe ShoppingList do
  let(:scale) {FactoryGirl.create(:ingredient_scale, name:"ounce")}



  let(:gin) {FactoryGirl.create(:ingredient, name: "gin", ingredient_scale_id: scale.id)}
  let(:tonic) {FactoryGirl.create(:ingredient, name: "tonic", ingredient_scale_id: scale.id)}
  let(:eggs) {FactoryGirl.create(:ingredient, name: "eggs", ingredient_scale_id: scale.id)}

  let(:gin_1) {FactoryGirl.build(:ingredient_amount, ingredient_id: gin.id, amount:1.5 )}
  let(:gin_2) {FactoryGirl.build(:ingredient_amount, ingredient_id: gin.id, amount: 3.5 )}
  let(:tonic_1) {FactoryGirl.build(:ingredient_amount, ingredient_id: tonic.id, amount: 2.0 )}
  let(:tonic_2) {FactoryGirl.build(:ingredient_amount, ingredient_id: tonic.id, amount: 3.0 )}
  let(:eggs_1) {FactoryGirl.build(:ingredient_amount, ingredient_id: eggs.id, amount: 2.0 )}


 


  it 'should enumerate items in the supplied array' do
    items = ['a','b','c']
    list = ShoppingList.new(items)
    expect(list).to include('a')
    expect(list).to include('b')
    expect(list).to include('c')
    expect(list).not_to include('d')
  end
  it 'should return empty if nothing in the array' do
    items = []
    list = ShoppingList.new(items)
    expect(list).to be_empty

  end


  # context 'combining with other shopping lists' do


  #   let(:gin_martini) {ShoppingList.new([gin_1])}
  #   let(:tonic_syrup) {ShoppingList.new([tonic_1])}
  #   let(:gin_and_tonic) {ShoppingList.new([gin_2, tonic_1])}

  #   it 'combines two mutually exclusive lists' do
  #     result = gin_martini + tonic_syrup
  #     expect(result).to include(gin_1)
  #     expect(result).to include(tonic_1)

  #     expect(result).to be_a ShoppingList
  #   end

  #   it 'combines two lists with overlapping ingredient amounts' do
  #     result = tonic_syrup + gin_and_tonic
  #     expect(result).to include(gin_2)
  #     expect(result).to include_ingredient_amount(tonic, 4.0) 
  #     #expect(result).to include(tonic_1)
  #   end
  # end

  context 'combining with other shopping lists using add_to' do


    let(:gin_martini) {ShoppingList.new([gin_1])}
    let(:tonic_syrup) {ShoppingList.new([tonic_1])}
    let(:gin_and_tonic) {ShoppingList.new([gin_2, tonic_2])}

    it 'combines two mutually exclusive lists' do
      result = gin_martini.add_to tonic_syrup
      expect(result).to include(gin_1)
      expect(result).to include(tonic_1)

      expect(result).to be_a ShoppingList
    end

    it 'combines two lists with overlapping ingredient amounts' do
      result = tonic_syrup.add_to gin_and_tonic
      expect(result).to include(gin_2)
      expect(result).to include_ingredient_amount(tonic,5.0) 
      expect(result).to_not include_ingredient_amount(tonic, 3.0)
      puts result.inspect
    end
  end
end