import 'dart:convert';

Leavetype leavetypeFromJson(String str) => Leavetype.fromJson(json.decode(str));

String leavetypeToJson(Leavetype data) => json.encode(data.toJson());

class Leavetype {
  Leavetype({
    this.data,
    this.message,
  });

  Data data;
  String message;

  factory Leavetype.fromJson(Map<String, dynamic> json) => Leavetype(
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
    this.leaveTypes,
  });

  List<LeaveType> leaveTypes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    leaveTypes: List<LeaveType>.from(json["leaveTypes"].map((x) => LeaveType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "leaveTypes": List<dynamic>.from(leaveTypes.map((x) => x.toJson())),
  };
}

class LeaveType {
  LeaveType({
    this.id,
    this.name,
    this.entitlement,
    this.entitlementType,
    this.applicableTo,
    this.remarks,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String name;
  String entitlement;
  String entitlementType;
  String applicableTo;
  dynamic remarks;
  String createdBy;
  String updatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
    id: json["id"],
    name: json["name"],
    entitlement: json["entitlement"],
    entitlementType: json["entitlement_type"],
    applicableTo: json["applicable_to"],
    remarks: json["remarks"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "entitlement": entitlement,
    "entitlement_type": entitlementType,
    "applicable_to": applicableTo,
    "remarks": remarks,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
