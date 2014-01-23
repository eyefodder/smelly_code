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

require 'spec_helper'

describe IngredientAmount do
  let(:ingredient) {FactoryGirl.create(:ingredient)}
  let(:amount) {2.0}
  let(:item){IngredientAmount.new(amount:amount, ingredient_id:ingredient.id)}
  let(:scale) {FactoryGirl.create(:ingredient_scale)}



  subject {item}

  describe 'basic api:' do

    it{ should be_accessible :amount, :ingredient, :ingredient_scale}

    it { should validate_presence :amount, :ingredient_id}

  end

  describe 'inspect' do
    context 'single amounts' do
      before do
        item.amount = 1
      end
      it 'should handle single amount ingredients' do
        item.ingredient_scale = scale
        ingredient.ingredient_scale = scale
        ingredient.save!
        expect(item.inspect).to eq "An #{scale.name} of #{ingredient.name}"
      end
      it 'should handle single amount ingredients that should be a' do
        scale.name = 'pinch'
        item.ingredient_scale = scale
        scale.save
        expect(item.inspect).to eq "A #{scale.name} of #{ingredient.name}"
      end
      it 'should handle single ingredients with no scale - beginning with vowel' do
        expect(item.inspect).to eq "An #{ingredient.name}"
      end
      it 'should handle single ingredients with no scale - not beginning with vowel' do

        ingredient.name = 'poo'
        ingredient.save!
        expect(item.inspect).to eq "A #{ingredient.name}"
      end
    end
    context 'multiple amounts' do
      it 'should handle multiple amount ingredients' do
        item.ingredient_scale = scale
        expect(item.inspect).to eq "2 #{scale.name.pluralize} of #{ingredient.name}"
      end
      it 'should handle ingredients with no scale' do
        expect(item.inspect).to eq "2 #{ingredient.name.pluralize}"
      end
      it 'should truncate exact numbers so there is no trailing .0' do
        item.amount = 2.0
        expect(item.inspect).to eq "2 #{ingredient.name.pluralize}"
      end
      it 'should truncate exact numbers so there is no trailing .0' do
        item.amount = 2.5
        expect(item.inspect).to eq "2.5 #{ingredient.name.pluralize}"
      end
    end
    context 'fractional amounts' do
      before do
        item.amount = 0.5
      end

      it 'should handle half ingredients - no scale' do

        expect(item.inspect).to eq "Half an #{ingredient.name}"
      end
      it 'should handle half ingredients - no scale starts with vowel' do
        ingredient.name = 'poo'
        ingredient.save!
        expect(item.inspect).to eq "Half a #{ingredient.name}"
      end
      it 'should handle half ingredients -  scale starts with vowel' do
        item.ingredient_scale = scale
        ingredient.ingredient_scale = scale
        ingredient.save!
        expect(item.inspect).to eq "Half an #{scale.name} of #{ingredient.name}"
      end
      it 'should handle half ingredients -  scale starts with vowel' do
        scale.name = 'pinch'
        item.ingredient_scale = scale
        scale.save
        expect(item.inspect).to eq "Half a #{scale.name} of #{ingredient.name}"
      end
    end
    


  end

  it 'should return the ingredient scale associated with it' do

   scale = FactoryGirl.create(:ingredient_scale)
   ingredient = FactoryGirl.create(:ingredient, ingredient_scale_id:scale.id)
   item = IngredientAmount.new(amount:2, ingredient_id:ingredient.id)

   item.ingredient_scale.should == scale
      #its (:ingredient_scale) {should eq scale}
    end

    context 'addition' do
      let!(:item2) {IngredientAmount.new(amount: 3.2, ingredient_id: ingredient.id)}
      let!(:item3) {IngredientAmount.new(amount: 3.2, ingredient_id: ingredient.id+1)}

      it 'should be able to add ingredient amounts together' do

        result = item2 + item
        expect(result).to be_same_ingredient_as item
        expect(result).to be_same_ingredient_as item2
        expect(result.amount).to eq (item.amount + item2.amount)
      end
      it 'should throw an exception when adding different ingredients togeter' do
        expect { item2 + item3 }.to raise_error
      end
    end

    context 'comparing ingredients' do
      let(:ing) {FactoryGirl.create(:ingredient)}
      let(:amt1) {FactoryGirl.build(:ingredient_amount, ingredient_id: ing.id)}
      let(:amt2) {FactoryGirl.build(:ingredient_amount, ingredient_id: ing.id)}
      let(:amt3) {FactoryGirl.build(:ingredient_amount, ingredient_id: ing.id+1)}
      let(:amt4) {FactoryGirl.build(:ingredient_amount, ingredient_id: ing.id, amount: 34)}
      let(:amt5) {FactoryGirl.build(:ingredient_amount, ingredient_id: ing.id+1, amount: 34)}

      subject{amt1}
      it 'should return true with the same ingredient' do
        expect(amt1).to be_same_ingredient_as amt2
      end

      it 'should return false with different ingredient' do
        expect(amt1).to_not be_same_ingredient_as amt3
      end

      context 'comparing ingredient amounts' do
        it 'should return true with same ingredient and amount' do
          expect(amt1).to be_same_ingredient_amount_as amt2
        end
        it 'should return false with diff ingredient and same amount' do
          expect(amt1).to_not be_same_ingredient_amount_as amt3
        end
        it 'should return false with same ingredient and diff amount' do
          expect(amt1).to_not be_same_ingredient_amount_as amt4
        end
        it 'should return false with diff ingredient and diff amount' do
          expect(amt1).to_not be_same_ingredient_amount_as amt5
        end
        context 'aliasing == operator' do
          it 'should use same_ingredient_amount? to compare types' do
            expect(amt1).to eq amt2
            expect(amt1).to_not eq amt3
            expect(amt1).to_not eq amt4
            expect(amt1).to_not eq amt5
          end
        end
      end
    end



  end
