class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :ingredient_scale_id

      t.timestamps
    end
  end
end
