# == Schema Information
#
# Table name: ingredient_scales
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  shortname  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe IngredientScale do
	let(:scale) {FactoryGirl.create(:ingredient_scale)}
  # before { @scale = IngredientScale.new(name: "Ounce", shortname: "oz") }

  subject { scale }

  it { should be_accessible :name, :shortname, :ingredients}
  it { should validate_presence :name}
  it { should_not validate_presence :shortname}
  it { should have_unique_case_insensitive :name}
  it { should be_valid}



end
