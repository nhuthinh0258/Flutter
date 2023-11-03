import 'package:flutter/material.dart';

import 'package:meals/model/category.dart';
import 'package:meals/model/meal.dart';

// Constants in Dart should be written in lowerCamelcase.
const availableCategories = [
  Category(
    id: 'c1',
    title: 'Trái cây',
    color: Colors.purple,
  ),
  Category(
    id: 'c2',
    title: 'Rau',
    color: Colors.red,
  ),
  Category(
    id: 'c3',
    title: 'Củ quả',
    color: Colors.orange,
  ),
  Category(
    id: 'c4',
    title: 'Hoa',
    color: Colors.amber,
  ),
  Category(
    id: 'c5',
    title: 'Thịt lợn',
    color: Colors.blue,
  ),
  Category(
    id: 'c6',
    title: 'Thịt gà',
    color: Colors.green,
  ),
  Category(
    id: 'c7',
    title: 'Thịt bò',
    color: Colors.lightBlue,
  ),
  Category(
    id: 'c8',
    title: 'Đồ khô',
    color: Colors.lightGreen,
  ),
  Category(
    id: 'c9',
    title: 'Đồ tươi',
    color: Colors.pink,
  ),
  Category(
    id: 'c10',
    title: 'Đồ khác',
    color: Colors.teal,
  ),
];

const dummyMeals = [
  Meal(
    id: 'm1',
    categories: [
      'c1',
      'c2',
    ],
    title: 'Cam',
    affordability: 30000,
    complexity: Complexity.simple,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/c/c4/Orange-Fruit-Pieces.jpg',
    duration: 0,
    ingredients: [
      'Năng lượng	197 kJ (47 kcal)',
      'Cacbohydrat 11.75 g',
      'Chất béo 0.12 g',
      'Chất đạm 0.94 g',
      'Vitamin',
      'Nước	86.75 g'
    ],
    steps: [
      'Bóc vỏ ra để ăn',
      'Không ăn khi đang đói',
      'Tốt nhất khi dùng sau bữa ăn',
    ],
    isGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm2',
    categories: [
      'c2',
    ],
    title: 'Kiwi',
    affordability: 30000,
    complexity: Complexity.simple,
    imageUrl:
        'https://images.immediate.co.uk/production/volatile/sites/30/2020/02/Kiwi-fruits-582a07b.jpg',
    duration: 0,
    ingredients: [
      'Năng lượng	197 kJ (47 kcal)',
      'Cacbohydrat 11.75 g',
      'Chất béo 0.12 g',
      'Chất đạm 0.94 g',
      'Vitamin',
      'Nước	86.75 g'
    ],
    steps: [
      'Bóc vỏ ra để ăn',
      'Tốt nhất khi dùng sau bữa ăn',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm3',
    categories: [
      'c2',
      'c3',
    ],
    title: 'Cà chua',
    affordability: 30000,
    complexity: Complexity.simple,
    imageUrl:
        'https://images.freeimages.com/images/large-previews/4e5/tomatooos-3-1563917.jpg',
    duration: 15,
    ingredients: [
      'Năng lượng	197 kJ (47 kcal)',
      'Cacbohydrat 11.75 g',
      'Chất béo 0.12 g',
      'Chất đạm 0.94 g',
      'Vitamin',
      'Nước	86.75 g'
    ],
    steps: [
      'Rửa sạch',
      'Cắt theo miếng hoặc nhỏ hơn tùy bữa ăn',
      'Nấu trong khoảng 15p (Luộc, xào)',
      'Kết hợp với các nguyên liệu khác',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm4',
    categories: [
      'c4',
    ],
    title: 'Đào',
    affordability: 30000,
    complexity: Complexity.challenging,
    imageUrl:
        'https://thumbs.dreamstime.com/b/peach-fruit-half-leaf-isolated-white-background-jpg-209709073.jpg',
    duration: 0,
    ingredients: [
      'Năng lượng	197 kJ (47 kcal)',
      'Cacbohydrat 11.75 g',
      'Chất béo 0.12 g',
      'Chất đạm 0.94 g',
      'Vitamin',
      'Nước	86.75 g'
    ],
    steps: [
      'Cắt thành miếng hoặc nhỏ hơn tùy ý',
      'Ăn trực tiếp hoặc chế biến thành các món khác',
      'Không ăn khi đang đói',
      'Tốt nhất khi dùng sau bữa ăn',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm5',
    categories: [
      'c2'
      'c5',
      'c10',
    ],
    title: 'Thanh Long',
    affordability: 30000,
    complexity: Complexity.simple,
    imageUrl:
        'https://storage.googleapis.com/pluckk/uploads/4637-dragon.jpg',
    duration: 0,
    ingredients: [
      'Năng lượng	197 kJ (47 kcal)',
      'Cacbohydrat 11.75 g',
      'Chất béo 0.12 g',
      'Chất đạm 0.94 g',
      'Vitamin',
      'Nước	86.75 g'
    ],
    steps: [
      'Tách, bóc vỏ ra để ăn',
      'Không ăn khi đang đói',
      'Tốt nhất khi dùng sau bữa ăn',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm6',
    categories: [
      'c6',
      'c10',
    ],
    title: 'Súp lơ',
    affordability: 30000,
    complexity: Complexity.hard,
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/03/05/19/02/broccoli-1238250_640.jpg',
    duration: 15,
    ingredients: [
      'Năng lượng	197 kJ (47 kcal)',
      'Cacbohydrat 11.75 g',
      'Chất béo 0.12 g',
      'Chất đạm 0.94 g',
      'Vitamin',
      'Nước	86.75 g'
    ],
    steps: [
      'Rửa sạch rau',
      'Cắt thành bông nhỏ hơn',
      'Nấu trong khoảng 15p (luộc, xào)',
      'Kết hợp cùng các nguyên liệu khác',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm7',
    categories: [
      'c7',
    ],
    title: 'Cải thìa',
    affordability: 30000,
    complexity: Complexity.simple,
    imageUrl:
        'https://cdn.jwplayer.com/v2/media/N9xgU2LS/poster.jpg?width=720',
    duration: 15,
    ingredients: [
      'Năng lượng	197 kJ (47 kcal)',
      'Cacbohydrat 11.75 g',
      'Chất béo 0.12 g',
      'Chất đạm 0.94 g',
      'Vitamin',
      'Nước	86.75 g'
    ],
    steps: [
      'Rửa sạch rau',
      'Cắt, tách rau nhỏ hơn tùy bữa ăn ',
      'Nấu trong 15p (luộc, xào)',
      'Kết hợp cùng các nguyên liệu khác.'
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm8',
    categories: [
      'c8',
    ],
    title: 'Ngô',
    affordability: 30000,
    complexity: Complexity.challenging,
    imageUrl:
        'https://s30386.pcdn.co/wp-content/uploads/2019/08/FreshCorn_HNL1309_ts135846041.jpg',
    duration: 30,
    ingredients: [
      '4 Chicken Breasts',
      '1 Onion',
      '2 Cloves of Garlic',
      '1 Piece of Ginger',
      '4 Tablespoons Almonds',
      '1 Teaspoon Cayenne Pepper',
      '500ml Coconut Milk',
    ],
    steps: [
      'Slice and fry the chicken breast',
      'Process onion, garlic and ginger into paste and sauté everything',
      'Add spices and stir fry',
      'Add chicken breast + 250ml of water and cook everything for 10 minutes',
      'Add coconut milk',
      'Serve with rice'
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm9',
    categories: [
      'c9',
    ],
    title: 'Hành tím',
    affordability: 30000,
    complexity: Complexity.hard,
    imageUrl:
        'https://i0.wp.com/laidbackgardener.blog/wp-content/uploads/2017/03/20170323a.jpg',
    duration: 3,
    ingredients: [
      '1 Teaspoon melted Butter',
      '2 Tablespoons white Sugar',
      '2 Ounces 70% dark Chocolate, broken into pieces',
      '1 Tablespoon Butter',
      '1 Tablespoon all-purpose Flour',
      '4 1/3 tablespoons cold Milk',
      '1 Pinch Salt',
      '1 Pinch Cayenne Pepper',
      '1 Large Egg Yolk',
      '2 Large Egg Whites',
      '1 Pinch Cream of Tartar',
      '1 Tablespoon white Sugar',
    ],
    steps: [
      'Preheat oven to 190°C. Line a rimmed baking sheet with parchment paper.',
      'Brush bottom and sides of 2 ramekins lightly with 1 teaspoon melted butter; cover bottom and sides right up to the rim.',
      'Add 1 tablespoon white sugar to ramekins. Rotate ramekins until sugar coats all surfaces.',
      'Place chocolate pieces in a metal mixing bowl.',
      'Place bowl over a pan of about 3 cups hot water over low heat.',
      'Melt 1 tablespoon butter in a skillet over medium heat. Sprinkle in flour. Whisk until flour is incorporated into butter and mixture thickens.',
      'Whisk in cold milk until mixture becomes smooth and thickens. Transfer mixture to bowl with melted chocolate.',
      'Add salt and cayenne pepper. Mix together thoroughly. Add egg yolk and mix to combine.',
      'Leave bowl above the hot (not simmering) water to keep chocolate warm while you whip the egg whites.',
      'Place 2 egg whites in a mixing bowl; add cream of tartar. Whisk until mixture begins to thicken and a drizzle from the whisk stays on the surface about 1 second before disappearing into the mix.',
      'Add 1/3 of sugar and whisk in. Whisk in a bit more sugar about 15 seconds.',
      'whisk in the rest of the sugar. Continue whisking until mixture is about as thick as shaving cream and holds soft peaks, 3 to 5 minutes.',
      'Transfer a little less than half of egg whites to chocolate.',
      'Mix until egg whites are thoroughly incorporated into the chocolate.',
      'Add the rest of the egg whites; gently fold into the chocolate with a spatula, lifting from the bottom and folding over.',
      'Stop mixing after the egg white disappears. Divide mixture between 2 prepared ramekins. Place ramekins on prepared baking sheet.',
      'Bake in preheated oven until scuffles are puffed and have risen above the top of the rims, 12 to 15 minutes.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm10',
    categories: [
      'c2',
      'c5',
      'c10',
    ],
    title: 'Bí ngòi',
    affordability: 30000,
    complexity: Complexity.simple,
    imageUrl:
        'https://dalatfarm.net/wp-content/uploads/2022/03/bi-ngoi-xanh-da-lat.jpg',
    duration: 12,
    ingredients: [
      'White and Green Asparagus',
      '30g Pine Nuts',
      '300g Cherry Tomatoes',
      'Salad',
      'Salt, Pepper and Olive Oil'
    ],
    steps: [
      'Wash, peel and cut the asparagus',
      'Cook in salted water',
      'Salt and pepper the asparagus',
      'Roast the pine nuts',
      'Halve the tomatoes',
      'Mix with asparagus, salad and dressing',
      'Serve with Baguette'
    ],
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
  ),
];