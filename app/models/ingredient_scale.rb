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

class IngredientScale < ActiveRecord::Base
	has_many :ingredients
	before_save { name.downcase!}
	validates :name, presence: true, uniqueness: {case_sensitive: false}
end
