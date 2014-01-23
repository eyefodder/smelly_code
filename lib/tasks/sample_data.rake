require File.expand_path('../../../app/helpers/food', __FILE__)

namespace :db do
    desc "Fill database with sample data"
    task populate: :environment do

        
        IngredientScale.create!(name: "Ounce",shortname: "oz")
        IngredientScale.create!(name: "gram",shortname: "g")
        IngredientScale.create!(name: "teaspoon",shortname: "tsp")
        IngredientScale.create!(name: "Tablespoon",shortname: "tbsp")
        IngredientScale.create!(name: "Cup",shortname: "c")
        IngredientScale.create!(name: "pinch")

        scales = IngredientScale.all
        numscales = scales.length+2 #add 1 so we can have ingredients woith no scale

      
        50.times do |n|
            name = Faker::Food.ingredient
            scale = scales[rand(numscales)]
            id  = scale ? scale.id : nil
            Ingredient.create(name:name, ingredient_scale_id:id)
        end

        30.times do |n|
            recipe = Recipe.new(name:Faker::Food.recipe_name, image_uri:Faker::Food.image_uri, servings:2)
            recipe.save
            10.times do |m|
                # rand_id = rand(Ingredient.count)
                # rand_record = Ingredient.first(:conditions => [ "id >= ?", rand_id])
                rand_ingredient = Ingredient.first(:offset => rand(Ingredient.count))


                # amt = IngredientAmount.create!(amount:rand(12)+1, ingredient: rand_record)
               recipe.add_ingredient(rand_ingredient,rand(12)+1 )


                # recipe.recipe_ingredient_amounts.create(ingredient_amount_id:amt.id)
                # puts("created #{amt.inspect} for #{recipe.name} from record #{rand_record.inspect}")
            end
        end




    end

end