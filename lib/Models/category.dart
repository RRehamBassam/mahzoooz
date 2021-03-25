class Category {
  final int categoryId;
  final String name;
  Category({this.categoryId, this.name});
}

final trainCategory = Category(
  categoryId: 0,
  name: 'أقوى العروض',
);

final busCategory = Category(
  categoryId: 1,
  name: 'الأكثر مبيعاً',
);

final planeCategory = Category(
  categoryId: 2,
  name: 'العروض الجديدة',
);
final trainCategory1 = Category(
  categoryId: 3,
  name: 'الأعلى تقييما',
);
final categories = [
  trainCategory,
  busCategory,
  planeCategory,
  trainCategory1,

];
