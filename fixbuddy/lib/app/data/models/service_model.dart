class ServiceModel {
  final int id;
  final String name;
  final String? description;
  final double price;
  final String status;
  final String? image;
  final int categoryId;
  final int subCategoryId;

  ServiceModel({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.status,
    this.image,
    required this.categoryId,
    required this.subCategoryId,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: double.tryParse(json['price'].toString()) ?? 0,
      status: json['status'],
      image: json['image'],
      categoryId: json['category']['id'],
      subCategoryId: json['sub_category']['id'],
    );
  }
}
