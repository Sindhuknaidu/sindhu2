// To parse this JSON data, do
//
//     final applyleave = applyleaveFromJson(jsonString);

import 'dart:convert';

Applyleave applyleaveFromJson(String str) => Applyleave.fromJson(json.decode(str));

String applyleaveToJson(Applyleave data) => json.encode(data.toJson());

class Applyleave {
  Applyleave({
    this.data,
    this.message,
  });

  Data data;
  String message;

  factory Applyleave.fromJson(Map<String, dynamic> json) => Applyleave(
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
    this.applyLeave,
  });

  ApplyLeave applyLeave;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    applyLeave: ApplyLeave.fromJson(json["applyLeave"]),
  );

  Map<String, dynamic> toJson() => {
    "applyLeave": applyLeave.toJson(),
  };
}

class ApplyLeave {
  ApplyLeave({
    this.id,
    this.employeeId,
    this.leaveType,
    this.fromDate,
    this.fromSection,
    this.toDate,
    this.toSection,
    this.totalLeave,
    this.remarks,

  });

  int id;
  String employeeId;
  String leaveType;
  String fromDate;
  String fromSection;
  String toDate;
  String toSection;
  String totalLeave;
  String remarks;


  factory ApplyLeave.fromJson(Map<String, dynamic> json) => ApplyLeave(
    id: json["id"],
    employeeId: json["employeeId"],
    leaveType: json["leaveType"],
    fromDate: json["fromDate"],
    fromSection: json["fromSection"],
    toDate: json["toDate"],
    toSection: json["toSection"],
    totalLeave: json["total_leave"],
    remarks: json["Remarks"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employeeId": employeeId,
    "leaveType": leaveType,
    "fromDate": fromDate,
    "fromSection": fromSection,
    "toDate": toDate,
    "toSection": toSection,
    "total_leave": totalLeave,
    "Remarks": remarks,

  };
}
