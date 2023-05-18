import 'dart:convert';

List<RetailRegion> retailRegionFromJson(String str) => List<RetailRegion>.from(json.decode(str).map((x) => RetailRegion.fromJson(x)));

String retailRegionToJson(List<RetailRegion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

/// To parse this JSON data, do
///    final retailRegion = retailRegionFromJson(jsonString);
class RetailRegion {
  RetailRegion({
    this.id,
    this.regionName,
    this.city,
    this.province,
    this.country,
    this.datecreated,
    this.notes,
    this.deleted,
    this.status,
  });

  final String id;
  final String regionName;
  final String city;
  final String province;
  final String country;
  final DateTime datecreated;
  final String notes;
  final String deleted;
  final String status;

  RetailRegion copyWith({
    String id,
    String regionName,
    String city,
    String province,
    String country,
    DateTime datecreated,
    String notes,
    String deleted,
    String status,
  }) =>
      RetailRegion(
        id: id ?? this.id,
        regionName: regionName ?? this.regionName,
        city: city ?? this.city,
        province: province ?? this.province,
        country: country ?? this.country,
        datecreated: datecreated ?? this.datecreated,
        notes: notes ?? this.notes,
        deleted: deleted ?? this.deleted,
        status: status ?? this.status,
      );

  factory RetailRegion.fromJson(Map<String, dynamic> json) => RetailRegion(
    id: json["id"],
    regionName: json["region_name"],
    city: json["city"],
    province: json["province"],
    country: json["country"],
    datecreated: DateTime.parse(json["datecreated"]),
    notes: json["notes"],
    deleted: json["deleted"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "region_name": regionName,
    "city": city,
    "province": province,
    "country": country,
    "datecreated": datecreated.toIso8601String(),
    "notes": notes,
    "deleted": deleted,
    "status": status,
  };
}
