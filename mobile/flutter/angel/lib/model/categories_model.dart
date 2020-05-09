class CategoriesModel {
  String name;
  String rate;
  String image;

  CategoriesModel({
    this.name,
    this.rate,
    this.image,
  });
}

List<CategoriesModel> categoriesModel = [
  CategoriesModel(
    name: 'Home Dusting',
    rate: 'R120/h',
    image: 'home_dusting.jpg',
  ),
  CategoriesModel(
    name: 'Folding Clothes',
    rate: 'R100/h',
    image: 'folding_clothes.jpg',
  )
];
