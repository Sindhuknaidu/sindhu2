import 'dart:convert';

Expensedetails expensedetailsFromJson(String str) => Expensedetails.fromJson(json.decode(str));

String expensedetailsToJson(Expensedetails data) => json.encode(data.toJson());

class Expensedetails {
  Expensedetails({
    this.data,
    this.message,
  });

  Data data;
  String message;

  factory Expensedetails.fromJson(Map<String, dynamic> json) => Expensedetails(
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
    this.unsubmitted,
    this.unreported,
    this.submitted,
  });

  String unsubmitted;
  String unreported;
  String submitted;

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    unsubmitted: json["unsubmitted"],
    unreported: json["unreported"],
    submitted: json["submitted"],
  );

  Map<String, dynamic> toJson() => {
    "unsubmitted": unsubmitted,
    "unreported": unreported,
    "submitted": submitted,
  };
}
