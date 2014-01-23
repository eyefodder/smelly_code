module Faker
  module Food
    extend ModuleUtils
    extend self

    def recipe_name
      case rand(4)
      when 0 then "#{ingredient}, #{ingredient} and  #{adjective} #{cooking_method} #{ingredient}"
      when 1 then "#{adjective} #{cooking_method} #{ingredient}"
      else        "#{cooking_method} #{ingredient} with #{ingredient} and #{ingredient}"
      end
    end

    def meal_name
      case rand(4)
      when 0 then "A #{meal_type} of #{recipe_name}"
      when 1 then "#{ingredient}, #{ingredient} and #{ingredient}"
      else        recipe_name
      end
    end

    def meal_type
      MEAL_TYPES.rand
    end

    def ingredient
      INGREDIENTS.rand
    end

    def cooking_method
      METHODS.rand
    end

    def adjective
      ADJECTIVES.rand
    end

    def image_uri
      IMAGE_URIS.rand
    end

    # def last_name
    #   LAST_NAMES.rand
    # end

    # def prefix
    #   PREFIXES.rand
    # end

    # def suffix
    #   SUFFIXES.rand
    # end

    MEAL_TYPES = k %w(Salad Mid-week\ Supper Plate Meal)

    ADJECTIVES = k %w(Gently Lightly Slow Seven-hour Classic Traditional)

    METHODS = k %w(Roast Fried Boiled Grilled Seared Stewed Pickled Curried)

    INGREDIENTS = k %w(Almonds  Anchovy  Apple  Artichoke  Arugula  Asafoetida  Asparagus  
      Avocado  Bacon  Balsamic\ Vinegar  Banana  Barley  Basil  Bay\ Leaves  Beef  Beets  
      Blowfish  Blue\ Cheese  Bluefish  Bok\ Choy  Bonito  Breadcrumbs  Broccoli  Bulghur\ Wheat  
      Burdock\ Root  Butter  Butterfish  Buttermilk  Cannelloni  Capers  Caraway  Cardamon  
      Carrots  Casarecce  Cauliflower  Celeriac  Celery\ Salt  Cherries  Chicken  Chicken\ Liver  
      Chickpeas  Chickweed  Chilli  Chorizo  Cider  Cilantro  Clams  Cobia  Coconut  
      Collard\ Greens  Coriander  Corn  Cous\ Cous  Cranberry\ Beans  Cream  Crème\ Fraîche  
      Cucumber  Cumin  Curry\ Leaves  Curry\ Powder  Duck  Edamame  Eggplant  Eggs  Endive  
      Farro  Fava\ Beans  Fava\ Beans  Fava\ Greens  Fennel  Fenugreek  Feta\ Cheese  Fiddlehead\ Ferns  
      Figs  Filei  Fish  Fish\ Sauce  Flour  Galangal  Garam\ Masala  Garlic  Garlic\ Chives  Ginger  
      Gnocchi  Goat\ Cheese  Gooseberries  Grapes  Green\ Beans  Green\ Garlic  Green\ Shallots  
      Ground\ Cherries  Halloumi  Harissa  Herring  Honey  Japanese\ Red\ Pepper  Jerusalem\ Artichokes  
      Juniper  Juniper\ Berries  Kaffir\ Lime\ Leaves  Kale  Kingfish  Kirmizi\ Biber  Kohlrabi  Konbu  
      Labneh  Lamb  Lambsquarters  Leeks  Lemongrass  Lemons  Lentils  Lesser\ Celandine  Lettuce  
      Lima\ Beans  Lime  Linguini  Lovage  Mackerel  Mango  Mango\ Pickle  Marscapone  Meyer\ Lemons  
      Milk  Mint  Mirin  Miso  Mizuna  Monkfish  Mozzarella  Mushrooms  Mustard\ Greens  Mustard\ Seeds  
      Nectarine  Okra  Olives  Onions  Oregano  Pancetta  Paneer  Pappardelle  Paprika  Parmesan  Parsley  
      Parsnips  Pasta  Pasta,\ Grains,\ Beans  Pea\ Shoots  Peanut\ Butter  Peanuts  Pears  Peas  
      Peppers  Perilla\ Leaf  Pheasant  Pine\ Nuts  Pistachios  Plums  Pomegranate\ Molasses  Porgy  Pork  
      Potatoes  Prahok  Preserved\ Lemons  Prosciutto  Purslane  Quinoa  Radish  Rapini  Red\ Cabbage  
      Rhubarb  Rice  Rice\ Vinegar  Ricotta  Ricotta\ Salata  Roasted\ Rice\ Powder  Rosemary  Rutabaga  
      Rye\ Bread  Saffron  Sake  Sausage  Scallions  Scallops  Sea\ Bass  Sesame\ Seeds  Shallots  
      Sherry\ Vinegar  Skate  Smoked\ Fish  Smoked\ Salt  Sole  Sorrel  Soy\ Sauce  Spaghetti  Spinach  
      Spring\ Onions  Squash  Squid  Stinging\ Nettles  Sugar  Sumac  Sweet\ Potato  Swiss\ Chard  Tamarind  
      Tarragon  Tatsoi  Thai\ Basil  Thyme  Tofu  Tomatillo  Tomatoes  Tuna  Turmeric  Turnips  Vinegar  
      Walnuts  Watercress  Watermelon  Whiting  Wild\ Garlic  Wild\ Mustard  Wine\ Vinegar  Yoghurt  Za'atar  Zucchini)

IMAGE_URIS = k %w(http://barnesandhoggetts.com/wp-content/uploads/2013/11/20131113-P1060204-1024x1024.jpg 
  http://barnesandhoggetts.com/wp-content/uploads/2013/11/20131112-P1060175-1024x1024.jpg
  http://barnesandhoggetts.com/wp-content/uploads/2013/10/20131029-P1060074-1024x1024.jpg
  http://barnesandhoggetts.com/wp-content/uploads/2013/10/20131028-P1060049-1024x1024.jpg
  http://barnesandhoggetts.com/wp-content/uploads/2013/10/20131022-P1050997-1024x1024.jpg
  http://barnesandhoggetts.com/wp-content/uploads/2013/10/20131022-P1050997-1024x1024.jpg
  http://barnesandhoggetts.com/wp-content/uploads/2013/10/20131021-P1050960-1024x1024.jpg
  http://barnesandhoggetts.com/wp-content/uploads/2013/10/20131016-P10509101-1024x1024.jpg
  http://barnesandhoggetts.com/wp-content/uploads/2013/10/20131015-P1050795-1024x1024.jpg
  http://barnesandhoggetts.com/wp-content/uploads/2013/10/20131014-P1050711-1024x1024.jpg
  http://barnesandhoggetts.com/wp-content/uploads/2013/10/20131009-P1050623-1024x1024.jpg
  http://barnesandhoggetts.com/wp-content/uploads/2013/10/20131008-P1050601-1024x1024.jpg
  http://barnesandhoggetts.com/wp-content/uploads/2013/10/20131007-P1050554-1024x1024.jpg
  http://barnesandhoggetts.com/wp-content/uploads/2013/09/20130925-P1050420-1024x1024.jpg
  http://barnesandhoggetts.com/wp-content/uploads/2013/09/20130924-P1050376-1024x1024.jpg
  )

    # LAST_NAMES = k %w(Abbott Abernathy Abshire Adams Altenwerth Anderson
    #   Ankunding Armstrong Auer Aufderhar Bahringer Bailey Balistreri Barrows
    #   Bartell Bartoletti Barton Bashirian Batz Bauch Baumbach Bayer Beahan Beatty
    #   Bechtelar Becker Bednar Beer Beier Berge Bergnaum Bergstrom Bernhard
    #   Bernier Bins Blanda Blick Block Bode Boehm Bogan Bogisich Borer Bosco
    #   Botsford Boyer Boyle Bradtke Brakus Braun Breitenberg Brekke Brown Bruen
    #   Buckridge Carroll Carter Cartwright Casper Cassin Champlin Christiansen
    #   Cole Collier Collins Conn Connelly Conroy Considine Corkery Cormier Corwin
    #   Cremin Crist Crona Cronin Crooks Cruickshank Cummerata Cummings Dach
    #   D'Amore Daniel Dare Daugherty Davis Deckow Denesik Dibbert Dickens Dicki
    #   Dickinson Dietrich Donnelly Dooley Douglas Doyle DuBuque Durgan Ebert
    #   Effertz Eichmann Emard Emmerich Erdman Ernser Fadel Fahey Farrell Fay
    #   Feeney Feest Feil Ferry Fisher Flatley Frami Franecki Friesen Fritsch Funk
    #   Gaylord Gerhold Gerlach Gibson Gislason Gleason Gleichner Glover Goldner
    #   Goodwin Gorczany Gottlieb Goyette Grady Graham Grant Green Greenfelder
    #   Greenholt Grimes Gulgowski Gusikowski Gutkowski Gutmann Haag Hackett
    #   Hagenes Hahn Haley Halvorson Hamill Hammes Hand Hane Hansen Harber Harris
    #   Hartmann Harvey Hauck Hayes Heaney Heathcote Hegmann Heidenreich Heller
    #   Herman Hermann Hermiston Herzog Hessel Hettinger Hickle Hilll Hills Hilpert
    #   Hintz Hirthe Hodkiewicz Hoeger Homenick Hoppe Howe Howell Hudson Huel Huels
    #   Hyatt Jacobi Jacobs Jacobson Jakubowski Jaskolski Jast Jenkins Jerde Jewess
    #   Johns Johnson Johnston Jones Kassulke Kautzer Keebler Keeling Kemmer
    #   Kerluke Kertzmann Kessler Kiehn Kihn Kilback King Kirlin Klein Kling Klocko
    #   Koch Koelpin Koepp Kohler Konopelski Koss Kovacek Kozey Krajcik Kreiger
    #   Kris Kshlerin Kub Kuhic Kuhlman Kuhn Kulas Kunde Kunze Kuphal Kutch Kuvalis
    #   Labadie Lakin Lang Langosh Langworth Larkin Larson Leannon Lebsack Ledner
    #   Leffler Legros Lehner Lemke Lesch Leuschke Lind Lindgren Littel Little
    #   Lockman Lowe Lubowitz Lueilwitz Luettgen Lynch Macejkovic Maggio Mann Mante
    #   Marks Marquardt Marvin Mayer Mayert McClure McCullough McDermott McGlynn
    #   McKenzie McLaughlin Medhurst Mertz Metz Miller Mills Mitchell Moen Mohr
    #   Monahan Moore Morar Morissette Mosciski Mraz Mueller Muller Murazik Murphy
    #   Murray Nader Nicolas Nienow Nikolaus Nitzsche Nolan Oberbrunner O'Connell
    #   O'Conner O'Hara O'Keefe O'Kon Oga Okuneva Olson Ondricka O'Reilly Orn Ortiz
    #   Osinski Pacocha Padberg Pagac Parisian Parker Paucek Pfannerstill Pfeffer
    #   Pollich Pouros Powlowski Predovic Price Prohaska Prosacco Purdy Quigley
    #   Quitzon Rath Ratke Rau Raynor Reichel Reichert Reilly Reinger Rempel Renner
    #   Reynolds Rice Rippin Ritchie Robel Roberts Rodriguez Rogahn Rohan Rolfson
    #   Romaguera Roob Rosenbaum Rowe Ruecker Runolfsdottir Runolfsson Runte Russel
    #   Rutherford Ryan Sanford Satterfield Sauer Sawayn Schaden Schaefer
    #   Schamberger Schiller Schimmel Schinner Schmeler Schmidt Schmitt Schneider
    #   Schoen Schowalter Schroeder Schulist Schultz Schumm Schuppe Schuster Senger
    #   Shanahan Shields Simonis Sipes Skiles Smith Smitham Spencer Spinka Sporer
    #   Stamm Stanton Stark Stehr Steuber Stiedemann Stokes Stoltenberg Stracke
    #   Streich Stroman Strosin Swaniawski Swift Terry Thiel Thompson Tillman Torp
    #   Torphy Towne Toy Trantow Tremblay Treutel Tromp Turcotte Turner Ullrich
    #   Upton Vandervort Veum Volkman Von VonRueden Waelchi Walker Walsh Walter
    #   Ward Waters Watsica Weber Wehner Weimann Weissnat Welch West White Wiegand
    #   Wilderman Wilkinson Will Williamson Willms Windler Wintheiser Wisoky Wisozk
    #   Witting Wiza Wolf Wolff Wuckert Wunsch Wyman Yost Yundt Zboncak Zemlak
    #   Ziemann Zieme Zulauf)

    # PREFIXES = k %w(Mr. Mrs. Ms. Miss Dr.)

    # SUFFIXES = k %w(Jr. Sr. I II III IV V MD DDS PhD DVM)
  end
end