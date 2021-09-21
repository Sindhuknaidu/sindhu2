// To parse this JSON data, do
//
//     final allstatus = allstatusFromJson(jsonString);

import 'dart:convert';

Allstatus allstatusFromJson(String str) => Allstatus.fromJson(json.decode(str));

String allstatusToJson(Allstatus data) => json.encode(data.toJson());

class Allstatus {
  Allstatus({
    this.data,
    this.message,
  });

  Data data;
  String message;

  factory Allstatus.fromJson(Map<String, dynamic> json) => Allstatus(
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

  List<Leaf> leaves;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    leaves: List<Leaf>.from(json["leaves"].map((x) => Leaf.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "leaves": List<dynamic>.from(leaves.map((x) => x.toJson())),
  };
}

class Leaf {
  Leaf({
    this.leaveId,
    this.leaveType,
    this.fromDate,
    this.fromSection,
    this.toDate,
    this.toSection,
    this.remarks,
    this.totalLeave,
    this.status,
  });

  String leaveId;
  dynamic leaveType;
  String fromDate;
  String fromSection;
  String toDate;
  String toSection;
  String remarks;
  String totalLeave;
  String status;

  factory Leaf.fromJson(Map<String, dynamic> json) => Leaf(
    leaveId: json["leaveId"],
    leaveType: json["leaveType"],
    fromDate: json["fromDate"],
    fromSection: json["fromSection"],
    toDate: json["toDate"],
    toSection: json["toSection"],
    remarks: json["remarks"],
    totalLeave: json["totalLeave"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "leaveId": leaveId,
    "leaveType": leaveType,
    "fromDate": fromDate,
    "fromSection": fromSection,
    "toDate": toDate,
    "toSection": toSection,
    "remarks": remarks,
    "totalLeave": totalLeave,
    "status": status,
  };
}
