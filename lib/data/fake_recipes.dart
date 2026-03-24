import '../models/braai_recipe.dart';

const List<BraaiRecipe> fakeBraaiRecipes = <BraaiRecipe>[
  BraaiRecipe(
    id: 'boerewors',
    nameEn: 'Boerewors Roll',
    nameAf: 'Boereworsrol',
    descriptionEn: 'Juicy boerie on medium coals with a soft roll.',
    descriptionAf: 'Sappige boerie op medium kole met ’n sagte rol.',
    minutes: 18,
    heatLevel: BraaiHeatLevel.medium,
    tags: <String>['Classic', 'Quick', 'Family'],
    tipsEn: <String>[
      'Turn often to avoid flare-ups.',
      'Rest 2 minutes before slicing.',
    ],
    tipsAf: <String>[
      'Draai gereeld om opvlam te vermy.',
      'Laat rus 2 minute voor jy sny.',
    ],
  ),
  BraaiRecipe(
    id: 'lamb_chops',
    nameEn: 'Lamb Chops',
    nameAf: 'Lamskotelette',
    descriptionEn: 'Rosemary chops with a proper braai crust.',
    descriptionAf: 'Roosmaryn-kotelette met ’n lekker braaikors.',
    minutes: 14,
    heatLevel: BraaiHeatLevel.high,
    tags: <String>['Meat', 'High heat'],
    tipsEn: <String>[
      'Pat dry before seasoning for better browning.',
      'Salt after the first turn for less flare-up.',
    ],
    tipsAf: <String>[
      'Druk droog voor geur vir beter bruinering.',
      'Sout ná die eerste draai vir minder opvlam.',
    ],
  ),
  BraaiRecipe(
    id: 'braai_broodjies',
    nameEn: 'Braai Broodjies',
    nameAf: 'Braai Broodjies',
    descriptionEn: 'Cheese, tomato, onion—golden and smoky.',
    descriptionAf: 'Kaas, tamatie, uie—goudbruin en rokerig.',
    minutes: 10,
    heatLevel: BraaiHeatLevel.low,
    tags: <String>['Sides', 'Vegetarian'],
    tipsEn: <String>[
      'Butter the outside for an even toast.',
      'Keep on the cooler side of the grid.',
    ],
    tipsAf: <String>[
      'Botter die buitekant vir eweredige toast.',
      'Hou op die koeler kant van die rooster.',
    ],
  ),
];

