import 'dart:convert';

Leavehistory leavehistoryFromJson(String str) => Leavehistory.fromJson(json.decode(str));

String leavehistoryToJson(Leavehistory data) => json.encode(data.toJson());

class Leavehistory {
  Leavehistory({
    this.data,
    this.message,
  });

  Data data;
  String message;

  factory Leavehistory.fromJson(Map<String, dynamic> json) => Leavehistory(
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
    this.leaves,
  });

  List<dynamic> leaves;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    leaves: List<dynamic>.from(json["leaves"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "leaves": List<dynamic>.from(leaves.map((x) => x)),
  };
}

