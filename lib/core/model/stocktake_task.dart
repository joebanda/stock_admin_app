class StocktakeTask{

  String id;
  String id_store_branch;
  String stock_count_num;
  String chain_store_name;
  String store_branch_name;
  String include_expiry_date;
  String count_by_bins;
  String include_rate_of_sales;
  String includeBatchNo;
  String created_by;
  String status;
  String deleted;
  String date_created;
  String date_closed;
  String reference;
  String notes;

  StocktakeTask({
    this.id,
    this.id_store_branch,
    this.stock_count_num,
    this.chain_store_name,
    this.store_branch_name,
    this.include_expiry_date,
    this.count_by_bins,
    this.include_rate_of_sales,
    this.includeBatchNo,
    this.created_by,
    this.status,
    this.deleted,
    this.date_created,
    this.date_closed,
    this.reference,
    this.notes,
  });

  factory StocktakeTask.fromJson(Map<String, dynamic> json){
    return StocktakeTask(
      id: json['id'] as String,
      id_store_branch: json['id_store_branch'] as String,
      stock_count_num: json['stock_count_num'] as String,
      chain_store_name: json['chain_store_name'] as String,
      store_branch_name: json['store_branch_name'] as String,
      include_expiry_date: json['include_expiry_date'] as String,
      includeBatchNo: json['includeBatchNo'] as String,
      count_by_bins: json['count_by_bins'] as String,
      include_rate_of_sales: json['include_rate_of_sales'] as String,
      created_by: json['created_by'] as String,
      status: json['status'] as String,
      deleted: json['deleted'] as String,
      date_created: json['date_created'] as String,
      date_closed: json['date_closed'] as String,
      reference: json['reference'] as String,
      notes: json['notes'] as String,
    );
  }

}