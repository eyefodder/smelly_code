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

class Ingredient < ActiveRecord::Base
	belongs_to :ingredient_scale
	has_many :ingredient_amount
	default_scope -> { order('name ASC') }
	before_save { name.downcase!}
	 # validates :ingredient_scale_id, presence: true
	validates :name, presence: true, uniqueness: {case_sensitive: false}

	def scale_name
		ingredient_scale ? ingredient_scale.name : "n/a"
	end
end
