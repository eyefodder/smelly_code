FactoryGirl.define do
	factory :ingredient_scale do
		sequence (:name) do |n| 
			"ounce#{n}" 
		end
		shortname    "oz"
	end

	factory :ingredient do
		sequence (:name) do |n|
			"Ingredient #{n}" 
		end
	end

	factory :ingredient_amount do
		amount  1.0
		ingredient
	end

	factory :recipe do
    sequence (:name) do |n|
      "Recipe #{n}" 
    end
    image_uri "http://barnesandhoggetts.com/wp-content/uploads/2013/11/20131112-P1060175-1024x1024.jpg"
    servings 2
  end

end