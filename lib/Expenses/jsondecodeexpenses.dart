import 'dart:convert';

Expense expenseFromJson(String str) => Expense.fromJson(json.decode(str));

String expenseToJson(Expense data) => json.encode(data.toJson());

class Expense {
  Expense({
    this.success,
    this.statusCode,
    this.data,
    this.message,
  });

  bool success;
  int statusCode;
  Data data;
  String message;

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    success: json["success"],
    statusCode: json["statusCode"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "statusCode": statusCode,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.histories,
  });

  List<History> histories;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    histories: List<History>.from(json["histories"].map((x) => History.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "histories": List<dynamic>.from(histories.map((x) => x.toJson())),
  };
}

class History {
  History({
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
  String date;
  String merchant;
  String description;
  String attachments;
  String companyId;
  String status;


  factory History.fromJson(Map<String, dynamic> json) => History(
    id: json["id"],
    employeeId:json["employee_id"],
    reference: json["reference"],
    categoryId: json["category_id"],
    currencyId: json["currency_id"],
    amount: json["amount"],
    date:json["date"],
    merchant: json["merchant"],
    description: json["description"],
    attachments: json["attachments"],
    companyId: json["company_id"],
    status: json["status"],


  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id":employeeId,
    "reference": reference,
    "category_id": categoryId,
    "currency_id": currencyId,
    "amount": amount,
    "date": date,
    "merchant": merchant,
    "description": description,
    "attachments": attachments,
    "company_id": companyId,
    "status": status,

  };
}


