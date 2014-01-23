class CreateIngredientScales < ActiveRecord::Migration
	def change
		create_table :ingredient_scales do |t|
			t.string :name
			t.string :shortname

			t.timestamps
		end
	end
end
