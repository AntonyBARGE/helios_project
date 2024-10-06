String packArticles(String articles) {
  List<int> items = articles.split('').map(int.parse).toList();
  List<List<int>> boxes = [];

  // Trier les articles par ordre décroissant
  items.sort((a, b) => b.compareTo(a));

  for (int item in items) {
    bool packed = false;

    print(boxes);
    for (List<int> box in boxes) {
      // Recalculer la contenance du carton
      int currentBox = box.reduce((prev, element) => prev + element);
      // Essayer de placer l'article dans un carton existant
      if (currentBox + item <= 10) {
        box.add(item);
        packed = true;
        break;
      }
    }

    // Si l'article n'a pas pu être placé dans un box existant, créer un nouveau carton
    if (!packed) {
      boxes.add([item]);
    }
  }

  // Convertir les cartons en une chaîne de caractères formatée
  final result = boxes.map((box) => box.join('')).join('/');
  print(result);
  return result;
}
