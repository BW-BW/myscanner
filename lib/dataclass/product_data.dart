class ProductData {
  final int barcode;
  final String name;
  final bool vegan;
  final bool glutenfree;
  final bool halal;
  final String netto;
  final String calorie;
  final String fat;
  final String protein;
  final String carbo;
  final String sodium;
  final String sugar;
  final String details;
  final String imgurl;
  final String ingredients;

  ProductData(
      {required this.barcode,
      required this.name,
      required this.vegan,
      required this.glutenfree,
      required this.halal,
      required this.netto,
      required this.calorie,
      required this.fat,
      required this.protein,
      required this.carbo,
      required this.sodium,
      required this.sugar,
      required this.details,
      required this.imgurl,
      required this.ingredients});
}
