class RecipeGenerator
  MEATS = [
    'Pork',
    'Beef',
    'Chicken',
    'Turkey',
    'Duck',
    'Venison',
    'Goose',
    'Lamb',
    'Bison'
  ]

  VEGETABLES = [
    'Artichoke',
    'Arugula',
    'Asparagus',
    'Bell Peppers',
    'Beet Greens',
    'Beets',
    'Bok Choy',
    'Broccol',
    'Broccoli Rabe',
    'Brussels Sprouts',
    'Butternut Squash',
    'Cabbage',
    'Carrots',
    'Cauliflower',
    'Celery',
    'Chives',
    'Collard Greens',
    'Crookneck Squash',
    'Daikon Radis',
    'Dandelion Greens',
    'Eggplant',
    'Endive',
    'Garlic',
    'Green Onion',
    'Jicama',
    'Kale',
    'Kimch',
    'Kohlrabi',
    'Leeks',
    'Lettuce',
    'Mushroom',
    'Mustard Greens',
    'Okra',
    'Onions',
    'Parsnips',
    'Potatoes',
    'Pumpkin',
    'Sweet Potato',
    'Radicchio',
    'Radish',
    'Seaweed',
    'Shallots',
    'Spaghetti Squash',
    'Spinach',
    'Swiss Chard',
    'Tomatillo',
    'Tomatoes',
    'Turnips',
    'Watercress',
    'Water Chestnut',
    'Zucchin',
  ]

  FRUIT = [
    'Acerola',
    'Pomme',
    'Apple',
    'Apricots',
    'Avocado',
    'Banana',
    'Blackberries',
    'Blackcurrant',
    'Blueberries',
    'Breadfruit',
    'Cantaloupe',
    'Carambola',
    'Cherimoya',
    'Cherries',
    'Clementine',
    'Coconut Meat',
    'Cranberries',
    'Date Fruit',
    'Durian',
    'Elderberries',
    'Feijoa',
    'Figs',
    'Gooseberries',
    'Grapefruit',
    'Grapes',
    'Guava',
    'Honeydew Melon',
    'Jackfruit',
    'Jujube',
    'Kiwifruit',
    'Kumquat',
    'Lemon',
    'Lime',
    'Longan',
    'Loquat',
    'Lychee',
    'Mandarin',
    'Mango',
    'Mangosteen',
    'Mulberries',
    'Nectarine',
    'Orange',
    'Papaya',
    'Passion',
    'Peaches',
    'Pear',
    'Persimmon',
    'Pineapple',
    'Pitanga',
    'Plantain',
    'Plums',
    'Pomegranate',
    'Prunes',
    'Pummelo',
    'Quince',
    'Raspberries',
    'Rhubarb',
    'Sapodilla',
    'Sapote',
    'Soursop',
    'Strawberries',
    'Tamarind',
    'Tangerine',
    'Watermelon'
  ]

  GRAIN = [
    'Teff',
    'Wheat',
    'Oats',
    'Rice',
    'Corn',
    'Barley',
    'Sorghum',
    'Rye',
    'Millet',
    'Triticale',
    'Amaranth',
    'Buckwheat',
    'Quinoa'
  ]

  def generate
    app_id = ENV['EDAMAM_APP_ID']
    app_key = ENV['EDAMAM_APP_KEY']
    types = [:breakfast, :lunch, :dinner]
    selected_type = types.sample
    query = random_query(selected_type)
    calories2 = Random.new.rand(500..3000)
    response = HTTParty.get("https://api.edamam.com/search?app_id=#{app_id}&app_key=#{app_key}&q=#{query}&mealType=#{selected_type}")
    title = response.dig('hits', 0, 'recipe', 'label')
    ingredients = response.dig('hits', 0, 'recipe', 'ingredientLines')

    { title: title, ingredients: ingredients }
  end

  def random_query(type)
    case type
    when :breakfast
      return "#{FRUIT.sample} #{GRAIN.sample}"
    when :lunch
      return "#{MEATS.sample} #{GRAIN.sample}"
    when :dinner
      return "#{MEATS.sample} #{VEGETABLES.sample}"
    end
  end
end
