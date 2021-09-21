import 'dart:convert';

Catagories catagoriesFromJson(String str) => Catagories.fromJson(json.decode(str));

String catagoriesToJson(Catagories data) => json.encode(data.toJson());

class Catagories {
  Catagories({
    this.data,
    this.message,
  });

  Data data;
  String message;


  factory Catagories.fromJson(Map<String, dynamic> json) => Catagories(
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.categories,
  });

  List<Category> categories;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.category,
    this.accountCode,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String category;
  String accountCode;
  String status;
  String createdBy;
  String updatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;


  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    category: json["category"],
    accountCode: json["account_code"],
    status: json["status"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "account_code": accountCode,
    "status": status,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
