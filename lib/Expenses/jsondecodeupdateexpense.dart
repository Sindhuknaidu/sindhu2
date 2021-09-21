// To parse this JSON data, do
//
//     final updateexpense = updateexpenseFromJson(jsonString);

import 'dart:convert';

Updateexpense updateexpenseFromJson(String str) => Updateexpense.fromJson(json.decode(str));

String updateexpenseToJson(Updateexpense data) => json.encode(data.toJson());

class Updateexpense {
  Updateexpense({
    this.data,
    this.message,
  });

  Data data;
  String message;

  factory Updateexpense.fromJson(Map<String, dynamic> json) => Updateexpense(
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
    this.expense,
  });

  Expense expense;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    expense: Expense.fromJson(json["expense"]),
  );

  Map<String, dynamic> toJson() => {
    "expense": expense.toJson(),
  };
}

class Expense {
  Expense({
    this.id,
    this.employeeId,
    this.reference,
    this.categoryId,
    this.currencyId,
    this.amount,
    this.date,
    this.merchant,
    this.description,
    this.attachments,
    this.companyId,
    this.status,
  });

  int id;
  String employeeId;
  String reference;
  String categoryId;
  String currencyId;
  String amount;
  DateTime date;
  dynamic merchant;
  dynamic description;
  String attachments;
  String companyId;
  String status;

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    id: json["id"],
    employeeId: json["employee_id"],
    reference: json["reference"],
    categoryId: json["category_id"],
    currencyId: json["currency_id"],
    amount: json["amount"],
    date: DateTime.parse(json["date"]),
    merchant: json["merchant"],
    description: json["description"],
    attachments: json["attachments"],
    companyId: json["company_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    "reference": reference,
    "category_id": categoryId,
    "currency_id": currencyId,
    "amount": amount,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "merchant": merchant,
    "description": description,
    "attachments": attachments,
    "company_id": companyId,
    "status": status,
  };
}
