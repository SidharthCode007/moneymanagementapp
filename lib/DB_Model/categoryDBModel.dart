enum CategoryType {
  income,
  expense,
}

class CategoryModel {
  final String id;
  final String name;
  final bool isDeleted;
  final CategoryType type;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.type,
      this.isDeleted = false});
}
