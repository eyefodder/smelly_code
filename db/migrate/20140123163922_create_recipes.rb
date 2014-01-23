class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :servings
      t.string :image_uri

      t.timestamps
    end
  end
end
