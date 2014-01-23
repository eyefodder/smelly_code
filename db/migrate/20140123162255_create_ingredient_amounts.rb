class CreateIngredientAmounts < ActiveRecord::Migration
  def change
    create_table :ingredient_amounts do |t|
      t.decimal :amount
      t.integer :ingredient_id

      t.timestamps
    end
  end
end
