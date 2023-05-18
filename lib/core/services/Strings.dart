///Class contains constant strings like Web API urls, Titles etc...

class AppStrings{
   /// server1
  static const String ROOT = "http://oribicom.com/logistixpro";
  static const String HOST = "oribicom.com";
  static const String API_FOLDER = '/logistixpro';

  static const NAV_HOST = '192.168.0.242';
  static const String NAV_API_FOLDER = '/opa';

  ///server2
  //static const String ROOT = "schooladmin.oribicom.com";
  //static const String HOST = "schooladmin.oribicom.com";
  //static const String API_FOLDER = '';


  static const String GET_ALL_SUPPLIERS_ACTION = 'GET_ALL_SUPPLIERS';


  //Php scripts
   static var studentsJson = Uri.http(HOST, AppStrings.API_FOLDER+'/student_actions.php');
   static var yearGroupActionsScript = Uri.http(HOST, AppStrings.API_FOLDER+'/year_group_actions.php');
   static var classesActionsScript = Uri.http(HOST, AppStrings.API_FOLDER+'/classes_actions.php');


   static var loginJson = Uri.http(HOST, '${AppStrings.API_FOLDER}/login.php');
  static var accountsJson = Uri.http(HOST, AppStrings.API_FOLDER+'/accounts.php');
  static var companiesJson = Uri.http(HOST, AppStrings.API_FOLDER+'/company.php');
  static var casesJson = Uri.http(HOST, AppStrings.API_FOLDER+'/cases.php');
  static var stocktakeTaskJson = Uri.http(HOST, AppStrings.API_FOLDER+'/stocktake_task_actions.php');
  static var feenoteJson = Uri.http(HOST, AppStrings.API_FOLDER+'/feenote.php');
  static var feenoteDetailsJson = Uri.http(HOST, AppStrings.API_FOLDER+'/feenote_detail.php');
  static var paymentsJson = Uri.http(HOST, AppStrings.API_FOLDER+'/payments.php');
  static var billableJson = Uri.http(HOST, AppStrings.API_FOLDER+'/billable.php');
  static var currenciesJson = Uri.http(HOST, AppStrings.API_FOLDER+'/currencies.php');
  static var disbursementJson = Uri.http(HOST, AppStrings.API_FOLDER+'/disbursements.php');
  //static var expenseJson = Uri.http(HOST, AppStrings.API_FOLDER+'/expense.php');
  static var chainStoreActionsScript = Uri.http(HOST, AppStrings.API_FOLDER+'/chainstore_actions.php');
  static var connectionScript = Uri.http(HOST, AppStrings.API_FOLDER+'/connection.php');
  static var userActionsScript = '$HOST/user_actions.php';
  static var countedItemsActionScript = '$HOST/counted_items.php';


   static var invoiceJson = Uri.http(HOST, AppStrings.API_FOLDER+'/invoice.php');

   static var expenseJson = Uri.http(HOST, AppStrings.API_FOLDER+'/expense.php');
   static var clockingScript = Uri.http(HOST, AppStrings.API_FOLDER+'/clocking.php');



  //Actions
   static var GET_ALL_STUDENTS_BY_ACCOUNT_ID_ACTION = 'GET_ALL_STUDENTS_BY_ACCOUNT_ID';
   static var   GET_CLASS_BY_YEAR_GROUP = 'GET_CLASS_BY_YEAR_GROUP';

 static var  GET_ORDERS_COUNT_ACTION = 'GET_ORDERS_COUNT';
 static var GET_OPEN_TASKS_NOT_COUNTED_ACTION = 'GET_OPEN_TASKS_NOT_COUNTED';
 static var  GET_COUNT_OPEN_TASKS_ACTION = 'GET_COUNT_OPEN_TASKS';


  static var GET_ALL_ACTION = 'GET_ALL';

  static var ADD_USER_ACTION = 'ADD_USER';
  static var DELETE_USER_ACTION = 'DELETE_USER';
  static var UPDATE_USER_ACTION = 'UPDATE_USER';
  static var RESET_PASSWORD_ACTION = 'RESET_PASSWORD';
  static var GET_ALL_ACCOUNTS_ACTION = 'GET_ALL_ACCOUNTS';
  static var GET_ALL_CURRENCIES_ACTION = 'GET_ALL_CURRENCIES';
  static var GET_ALL_COMPANIES_ACTION = 'GET_ALL_COMPANIES';
  static var UPDATE_COMPANY_DETAILS_ACTION = 'UPDATE_COMPANY_DETAILS';
  static var UPDATE_COMPANY_BANK_DETAILS_ACTION = 'UPDATE_COMPANY_BANK_DETAILS';
  static var UPLOAD_LOGO_ACTION = 'UPLOAD_LOGO';
  static var ADD_CLIENT_ACTION = 'ADD_CLIENT';
  static var ADD_CASE_ACTION = 'ADD_CASE';
  static var GET_ALL_CASES_ACTION = 'GET_ALL_CASES';

  static var GET_ALL_FEENOTES_ACTION = 'GET_ALL_FEENOTES';
  static var GET_FEENOTE_DETAILS_ACTION = 'GET_FEENOTE_DETAILS';
  static var DELETE_FEENOTE_DETAILS_ACTION = 'DELETE_FEENOTE_DETAIL';
  static var ADD_FEENOTE_ACTION = 'ADD_FEENOTE';
  static var ADD_FEENOTE_DETAIL_ACTION = 'ADD_FEENOTE_DETAIL';
  static var GET_FEENOTE_TREND_ALL_USERS_ACTION = 'GET_FEENOTE_TREND_ALL_USERS';
  static var GET_FEENOTE_TREND_SELECTED_USER_ACTION = 'GET_FEENOTE_TREND_SELECTED_USER';


  static var GET_DEBTORS_ACTION = 'GET_DEBTORS';
  static var GET_CREDIT_ACTION = 'GET_CREDIT';


   static var ADD_INVOICE_ACTION = 'ADD_INVOICE';

   static var GET_UNPAID_FEENOTES_ACTION = 'GET_UNPAID_FEENOTES';
   static var GET_LAST_FEENOTE_ACTION = 'GET_LAST_FEENOTE';
   static var GET_LAST_INVOICE_ACTION = 'GET_LAST_INVOICE';

   static var GET_ALL_CLOCKING_ACTION = 'GET_ALL_CLOCKINGS';
   static var GET_TODAY_CLOCKING_ACTION = 'GET_TODAY_CLOCKINGS';
   static var GET_WEEK_CLOCKING_ACTION = 'GET_WEEK_CLOCKINGS';
   static var GET_MONTH_CLOCKING_ACTION = 'GET_MONTH_CLOCKINGS';
   static var GET_BILLABLE_ALL_USERS_TODAY_ACTION = 'GET_BILLABLE_ALL_USERS_TODAY';
   static var GET_BILLABLE_ALL_USERS_WEEK_ACTION = 'GET_BILLABLE_ALL_USERS_WEEK';
   static var GET_BILLABLE_ALL_USERS_MONTH_ACTION = 'GET_BILLABLE_ALL_USERS_MONTH';
   static var GET_PAYMENTS_ALL_USERS_TODAY_ACTION = 'GET_PAYMENTS_ALL_USERS_TODAY';
   static var GET_ALL_PAYMENTS_ACTION = 'GET_ALL_PAYMENTS';
   static var GET_LAST_PAYMENT_ACTION = 'GET_LAST_PAYMENT';
   static var ADD_PAYMENT_ACTION = 'ADD_PAYMENT';
   static var GET_PAYMENTS_ALL_USERS_MONTH_ACTION = 'GET_PAYMENTS_ALL_USERS_MONTH';
   static var GET_PAYMENTS_ALL_USERS_WEEK_ACTION = 'GET_PAYMENTS_ALL_USERS_WEEK';
   static var GET_EXPENSES_ALL_USERS_WEEK_ACTION = 'GET_EXPENSES_ALL_USERS_WEEK';
   static var GET_EXPENSES_ALL_USERS_TODAY_ACTION = 'GET_EXPENSES_ALL_USERS_TODAY';
   static var GET_EXPENSES_ALL_USERS_MONTH_ACTION = 'GET_EXPENSES_ALL_USERS_MONTH';
   static var GET_BILLABLE_SELECTED_USER_TODAY_ACTION = 'GET_BILLABLE_SELECTED_USER_TODAY';
   static var GET_BILLABLE_SELECTED_USER_MONTH_ACTION = 'GET_BILLABLE_SELECTED_USER_MONTH';
   static var GET_BILLABLE_SELECTED_USER_WEEK_ACTION = 'GET_BILLABLE_SELECTED_USER_WEEK';

   static var ADD_CLOCKING_ACTION = 'ADD_CLOCKING';
   static var UPDATE_CLOCKING_ACTION = 'UPDATE_CLOCKING';
   static var DELETE_CLOCKING_ACTION = 'DELETE_CLOCKING';


  static var salesLineJson = Uri.http(HOST, AppStrings.API_FOLDER+'/salesline_actions.php');
  static var salesHeaderJson = Uri.http(HOST, AppStrings.API_FOLDER+'/salesheader_actions.php');
  static var ordersJson = Uri.http(HOST, AppStrings.API_FOLDER+'/orders.php');


  static var storeBranchActionsScript = Uri.http(HOST, AppStrings.API_FOLDER+'/store_branch_actions.php');

  static var itemActionScript = Uri.http(HOST, AppStrings.API_FOLDER+'/items_actions.php');
  static var itemsActionsJson = Uri.http(HOST, AppStrings.API_FOLDER+'/items_actions.php');

  // static var salesPriceActionsJson = Uri.http(AppStrings.NAV_HOST, AppStrings.NAV_API_FOLDER+'/salesprice_nav_actions.ph');

  static var csvOrdersJson = Uri.http(HOST, AppStrings.API_FOLDER+'/csv_orders.php');



  static var staffLocationActionScript = Uri.http(HOST, AppStrings.API_FOLDER+'/staff_location_actions.php');
  static var storeBranchActionScript = Uri.http(HOST, AppStrings.API_FOLDER+'/store_branch_actions.php');
  static var retailRegionsActionScript = Uri.http(HOST, AppStrings.API_FOLDER+'/retail_region_actions.php');
  static var countActionScript = Uri.http(HOST, AppStrings.API_FOLDER+'/count_actions.php');



  static const String GET_ALL_ORDERS_ACTION = 'GET_ALL_ORDERS';
  static const String ADD_SALESHEADER = 'ADD_SALESHEADER';
  static const String ADD_SALELINE_LIST = 'ADD_SALELINE_LIST';
  static const String ADD_CSV_ORDER_LIST_ACTION = 'ADD_CSV_ORDER';
  static const String GET_OPEN_SALES_BY_USER = 'GET_OPEN_SALES_BY_USER';
  static const String  GET_ALL_IMAGE_URLS_ACTION = 'GET_ALL_IMAGE_URLS';

  static const String GET_DAYS_TO_EXPIRE ='GET_DAYS_TO_EXPIRE';
  static const String ADD_STOREBRANCH_ACTION = 'ADD_STOREBRANCH';
  static const String GET_BY_CHAINSTORE_ACTION = 'GET_BY_CHAINSTORE';

  static const String ADD_CHAINSTORE_ACTION = 'ADD_CHAINSTORE';

  static const String UPLOAD_ITEM_IMAGE_ACTION = 'UPLOAD_ITEM_IMAGE';

  static const String ADD_CLIENT2_ACTION = 'ADD_CLIENT2';

  static const String GET_OPEN_STOCKTASK_ACTION = 'GET_OPEN_STOCKTASK';



}

///Global variable showing the same loading message on all screens
String kLoadingMessage = 'Loading...';