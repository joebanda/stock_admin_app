import 'dart:convert';

import 'package:flutter/rendering.dart';


MasterUserModel userFromJson(String str) => MasterUserModel.fromJson(json.decode(str));

String userToJson(MasterUserModel data) => json.encode(data.toJson());

class MasterUserModel{
  MasterUserModel({
    this.id,
    this.email,
    this.password,
    this.create_time,
    this.last_loggin,
    this.db_name,
    this.id_organisation,
    this.status,
    this.job_role,
    this.first_name,
    this.last_name,
    this.other_name,
    this.mobile_phone,
    this.other_phone,
    this.primary_user,
    this.deleted,

  });

  String id;
  String email;
  String password;
  String create_time;
  String last_loggin;
  String db_name;
  String id_organisation;
  String status;
  String job_role;
  String first_name;
  String last_name;
  String other_name;
  String mobile_phone;
  String other_phone;
  String primary_user;
  String deleted;




  factory MasterUserModel.fromJson(Map<String, dynamic> json) => MasterUserModel(
    id: json["id"],
    email: json["email"],
    password: json["password"],
    create_time: json["create_time"],
    last_loggin: json["last_loggin"],
    db_name: json["db_name"],
    id_organisation: json["id_organisation"],
    status: json["status"],
    job_role: json["job_role"],
    first_name: json["first_name"],
    last_name: json["last_name"],
    other_name: json["other_name"],
    mobile_phone:  json["mobile_phone"] == null ? '' : json["mobile_phone"] as String,
    other_phone: json["other_phone"] == null ? '': json["other_phone"] as String,
    primary_user: json["primary_user"],
    deleted: json["deleted"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
    "create_time":create_time,
    "last_loggin": last_loggin,
    "db_name": db_name,
    "id_organisation":id_organisation,
    "status": status,
    "job_role": job_role,
    "first_name": first_name,
    "last_name": last_name,
    "other_name": other_name,
    "mobile_phone":mobile_phone,
    "other_phone": other_phone,
    "primary_user": primary_user,
    "deleted":deleted
  };
}
