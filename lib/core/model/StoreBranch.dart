// To parse this JSON data, do
//
//     final storeBranch = storeBranchFromJson(jsonString);

import 'dart:convert';

List<StoreBranch> storeBranchFromJson(String str) => List<StoreBranch>.from(json.decode(str).map((x) => StoreBranch.fromJson(x)));

String storeBranchToJson(List<StoreBranch> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreBranch {
  StoreBranch({
    this.id,
    this.idChainStore,
    this.idAssignedStaff,
    this.storeBranchName,
    this.location,
    this.addressline1,
    this.addressline2,
    this.city,
    this.country,
    this.postaladdress,
    this.phone,
    this.fax,
    this.email,
    this.primaryContactName,
    this.idPickRule,
    this.ruleDisabled,
    this.latitude,
    this.longtitude,
  });

  final String id;
  final String idChainStore;
  final dynamic idAssignedStaff;
  final String storeBranchName;
  final dynamic location;
  final dynamic addressline1;
  final dynamic addressline2;
  final String city;
  final String country;
  final dynamic postaladdress;
  final dynamic phone;
  final dynamic fax;
  final dynamic email;
  final dynamic primaryContactName;
  final dynamic idPickRule;
  final String ruleDisabled;
  final String latitude;
  final String longtitude;

  StoreBranch copyWith({
    String id,
    String idChainStore,
    dynamic idAssignedStaff,
    String storeBranchName,
    dynamic location,
    dynamic addressline1,
    dynamic addressline2,
    String city,
    String country,
    dynamic postaladdress,
    dynamic phone,
    dynamic fax,
    dynamic email,
    dynamic primaryContactName,
    dynamic idPickRule,
    String ruleDisabled,
    String latitude,
    String longtitude,
  }) =>
      StoreBranch(
        id: id ?? this.id,
        idChainStore: idChainStore ?? this.idChainStore,
        idAssignedStaff: idAssignedStaff ?? this.idAssignedStaff,
        storeBranchName: storeBranchName ?? this.storeBranchName,
        location: location ?? this.location,
        addressline1: addressline1 ?? this.addressline1,
        addressline2: addressline2 ?? this.addressline2,
        city: city ?? this.city,
        country: country ?? this.country,
        postaladdress: postaladdress ?? this.postaladdress,
        phone: phone ?? this.phone,
        fax: fax ?? this.fax,
        email: email ?? this.email,
        primaryContactName: primaryContactName ?? this.primaryContactName,
        idPickRule: idPickRule ?? this.idPickRule,
        ruleDisabled: ruleDisabled ?? this.ruleDisabled,
        latitude: latitude ?? this.latitude,
        longtitude: longtitude ?? this.longtitude,
      );

  factory StoreBranch.fromJson(Map<String, dynamic> json) => StoreBranch(
    id: json["id"],
    idChainStore: json["id_chain_store"],
    idAssignedStaff: json["id_assigned_staff"],
    storeBranchName: json["store_branch_name"],
    location: json["location"],
    addressline1: json["addressline1"],
    addressline2: json["addressline2"],
    city: json["city"],
    country: json["country"],
    postaladdress: json["postaladdress"],
    phone: json["phone"],
    fax: json["fax"],
    email: json["email"],
    primaryContactName: json["primary_contact_name"],
    idPickRule: json["id_pick_rule"],
    ruleDisabled: json["rule_disabled"],
    latitude: json["latitude"],
    longtitude: json["longtitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_chain_store": idChainStore,
    "id_assigned_staff": idAssignedStaff,
    "store_branch_name": storeBranchName,
    "location": location,
    "addressline1": addressline1,
    "addressline2": addressline2,
    "city": city,
    "country": country,
    "postaladdress": postaladdress,
    "phone": phone,
    "fax": fax,
    "email": email,
    "primary_contact_name": primaryContactName,
    "id_pick_rule": idPickRule,
    "rule_disabled": ruleDisabled,
    "latitude": latitude,
    "longtitude": longtitude,
  };
}
