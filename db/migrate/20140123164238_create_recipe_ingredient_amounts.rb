class CreateRecipeIngredientAmounts < ActiveRecord::Migration
  def change
    create_table :recipe_ingredient_amounts do |t|
      t.integer :recipe_id
      t.integer :ingredient_amount_id
      t.integer :ingredient_id

      t.timestamps
    end
  end
end
