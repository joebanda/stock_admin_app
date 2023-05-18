// To parse this JSON data, do
//
//     final staffLocation = staffLocationFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

List<StaffLocation> staffLocationFromJson(String str) => List<StaffLocation>.from(json.decode(str).map((x) => StaffLocation.fromJson(x)));

String staffLocationToJson(List<StaffLocation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StaffLocation {
  StaffLocation({
    @required this.id,
    @required this.idStaff,
    @required this.idStoreBranch,
  });

  final String id;
  final String idStaff;
  final String idStoreBranch;

  StaffLocation copyWith({
    String id,
    String idStaff,
    String idStoreBranch,
  }) =>
      StaffLocation(
        id: id ?? this.id,
        idStaff: idStaff ?? this.idStaff,
        idStoreBranch: idStoreBranch ?? this.idStoreBranch,
      );

  factory StaffLocation.fromJson(Map<String, dynamic> json) => StaffLocation(
    id: json["id"],
    idStaff: json["id_staff"],
    idStoreBranch: json["id_store_branch"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_staff": idStaff,
    "id_store_branch": idStoreBranch,
  };
}
