

class Supplier{
String  idsupplier;
String  id_created_by;
String  supplier_name;
String description;
String  vat;
String  payment_method;
String  date_created;
String  supplier_code;
String  status;
String  deleted;
String  contact_name;
String  contact_title;
String Address_line1;
String  Address_line2;
String  Area;
String City;
String  Country;
String  Phone;
String  email;
String  home_page;


  Supplier({

    this.idsupplier,
    this.id_created_by,
    this.supplier_name,
    this.description,
    this.vat,
    this.payment_method,
    this.date_created,
    this.supplier_code,
    this.status,
    this.deleted,
    this.contact_name,
    this.contact_title,
    this.Address_line1,
    this.Address_line2,
    this.Area,
    this.City,
    this.Country,
    this.Phone,
    this.email,
    this.home_page,

  });

  factory Supplier.fromJson(Map<String, dynamic> json){
    return Supplier(

      idsupplier: json['idsupplier'] as String,
      id_created_by: json['id_created_by'] as String,
      supplier_name: json['supplier_name'] as String,
      description: json['description'] as String,
      vat: json['vat'] as String,
      payment_method: json['payment_method'] as String,
      date_created: json['date_created'] as String,
      supplier_code: json['supplier_code'] as String,
      status: json['status'] as String,
      deleted: json['deleted'] as String,
      contact_name: json['contact_name'] as String,
      contact_title: json['contact_title'] as String,
      Address_line1: json['Address_line1'] as String,
      Address_line2: json['Address_line2'] as String,
      Area: json['Area'] as String,
      City: json['City'] as String,
      Country: json['Country'] as String,
      Phone: json['Phone'] as String,
      email: json['email'] as String,
      home_page: json['home_page'] as String,

    );
  }
}