enum VersionKey {
  VENDOR("Vendor"),
  BASE_OFFICE("Base Office"),
  SERVICE_POINT("Service Point"),
  JOB_TYPE("Job Type"),
  DOCUMENT_STATUS("Document Status"),
  REQUEST_TYPE("Request Type"),
  MMS_STATUS("MMS Status"),
  PROVIDER("Provider"),
  EDC_TYPE("EDC Type"),
  EDC_COMMUNICATION_TYPE("EDC Communication Type"),
  REPLACEMENT_TYPE("Replacement Type"),
  JOB_STATUS("Job Status"),
  JOB_STATUS_CATEGORY("Job Status Category"),
  NOTE("Note"),
  QRIS_MENU("QRIS Menu"),
  EDC_EQUIPMENT("EDC Equipment"),
  EDC_FEATURE_TEST_CASE("EDC Feature Test Case"),
  JOB_CATEGORY("Job Category"),
  TRANSACTION_TEST_CASE("Transaction Test Case"),
  OTHER_BANK_EDC("Other Bank EDC"),
  DOR_MENU("DOR Menu"),
  MARCOLL_UPDATE_STATUS("Marcoll Update Status"),
  EOS_UPDATE_STATUS("EOS Update Status"),
  TRAINING_MATERIAL("Training Material"),
  DAMAGE_TYPE("Damage Type"),
  SN_STOCK("SN Stock"),
  NON_SN_STOCK("Non SN Stock"),
  JOB_ORDER("Job Order"),
  APP_VERSION("APP VERSION"),
  OS_PATCH("OS PATCH"),
  STICKER_BANK("STICKER BANK"),
  INBOX("Inbox"),
  FITUR_EDC_BNI_MTI("FITUR EDC BNI MTI");

  final String alias;

  const VersionKey(this.alias);
}

class Parameter {
  static const bool API_PRINT_LOGGING_ENABLED = true;
  static const String CLIENT_ID = "r-tracker_mobile_api";
  static const String CLIENT_SECRET_KEY = "ci10cmFja2V yX21vYmlsZV9hcGk=";
  static const List<String> signalBars = ['1','2','3','4'];
}

class SwitchValues {
  static const String yes = "Yes";
  static const String no = "No";

  static bool valueToStatus(String? value){
    return (value ?? no) == yes;
  }

  static String statusToValue(bool status){
    return status ? yes : no;
  }
}

class ApiUrl {
  // static String MAIN_BASE =
  //     "https://fms.jadintracker.id/api_mobile/api_mobile/";
  // static String MAIN_BASE =
  //     "https://fms.jadintracker.id/api_mobile/Api_mobile_v1_2_12/";
  static String MAIN_BASE =
      "https://fms.jadintracker.id/api_mobile/Api_mobile_v1_2_13/";
  static String MOCK_BASE = 'https://posdemo.sisapp.com:8443/rtracker/api/';
  static String MOCK_LOCAL_BASE = 'https://192.168.2.1:11443/rtracker/api/';

  static String LOGIN = '/login';
  static String FORGOT_PASSWORD = '/forgot_password';
  static String LOGOUT = '/logout';
  static String SEND_LOCATION = '/send_location';
  static String CHECK_VERSION = '/check_version';
  static String VENDORS = '/vendors';
  static String BASE_OFFICES = '/base_offices';
  static String SERVICE_POINTS = '/service_points';
  static String JOB_TYPES = '/job_types';
  static String DOCUMENT_STATUSES = '/document_statuses';
  static String REQUEST_TYPES = '/request_types';
  static String MMS_STATUSES = '/mms_statuses';
  static String PROVIDERS = '/providers';
  static String EDC_TYPES = '/edc_types';
  static String APP_VERSION = '/app_version';
  static String OS_PATCH = '/os_patch';
  static String STICKER_BANK = '/sticker_bank';
  static String EDC_COMMUNICATION_TYPES = '/edc_communication_types';
  static String REPLACEMENT_TYPES = '/replacement_types';
  static String JOB_STATUSES = '/job_statuses';
  static String JOB_STATUS_CATEGORIES = '/job_status_categories';
  static String NOTES = '/notes';
  static String QRIS_MENUS = '/qris_menus';
  static String EDC_EQUIPMENTS = '/edc_equipments';
  static String EDC_FEATURE_TEST_cASES = '/edc_feature_test_cases';
  static String JOB_CATEGORIES = '/job_categories';
  static String TRANSACTION_TEST_CASES = '/transaction_test_cases';
  static String OTHER_BANK_EDCS = '/other_bank_edcs';
  static String DOR_MENUS = '/dor_menus';
  static String MARCOLL_UPDATE_STATUSES = '/marcoll_update_statuses';
  static String EOS_UPDATE_STATUSES = '/eos_update_statuses';
  static String TRAINING_MATERIALS = '/training_materials';
  static String DAMAGE_TYPES = '/damage_types';
  static String SN_STOCKS = '/sn_stocks';
  static String NON_SN_STOCKS = '/non_sn_stocks';
  static String JOB_ORDERS = '/job_orders';
  static String INBOXES = '/inboxes';
  static String SEND_TERIMA_SN_STOCK = '/send_terima_sn_stock';
  static String TERIMA_SN_STOCK = '/terima_sn_stock';
  static String SEND_TERIMA_NON_SN_STOCK = '/send_terima_non_sn_stock';
  static String TERIMA_SN_NON_STOCK = '/terima_sn_non_stock';
  static String SN_STOCK_PORTAL = '/sn_stock_portal';
  static String NON_SN_STOCK_PORTAL = '/non_sn_stock_portal';
  static String SEND_SN_REQUEST_RETUR = '/send_sn_request_retur';
  static String SEND_NON_SN_REQUEST_RETUR = '/send_non_sn_request_retur';
  static String SYNC_FINISHED_JO = "/send_check_id_job_selesai";
  static String FITUR_EDC_BNI_MTI = "/fitur_edc_bni_mti";
}

enum SharedPreferenceKey {
  SESSION_ID,
  LOGIN_RESPONSE,
  MERCHANT_IMAGE_ALLOW_GALLERY,
  MACHINE_IMAGE_ALLOW_GALLERY,
  MACHINE_SERIAL_NUMBER_PHOTO_ALLOW_GALLERY,
  TRANSACTION_TEST_IMAGE_ALLOW_GALLERY,
  QRIS_RECEIPT_IMAGE_ALLOW_GALLERY,
  BRIZZI_INSTALLMENT_RECEIPT_IMAGE_ALLOW_GALLERY,
  LAST_VERSIONING,
  MOCK,
  JOB_ORDER_FILTER,
  CHECK_VERSION_INTERVAL,
  SEND_LOCATION_INTERVAL,
  SEND_JOB_ORDER_INTERVAL,
  PAUSE_MAX,
  WEB_PORTAL_URL,
  LAST_LATITUDE,
  LAST_LONGITUDE,
  PIC_MERCHANT_IMAGE_ALLOW_GALLERY,
  ROLL_SALES_DRAFT_IMAGE_ALLOW_GALLERY,
  TRAINING_STATEMENT_LETTER_IMAGE_ALLOW_GALLERY,
  EDC_APP_IMAGE_ALLOW_GALLERY,
  OTHER_IMAGE_ALLOW_GALLERY,
}

enum SnStockCategory { MESIN, PROVIDER, SAMCARD }

enum ImageMandatoryKey {
  signature,
  merchant,
  machine,
  serialNumber,
  picMerchant,
  rollSalesDraft,
  trainingStatementLetter,
  edcApp,
  other,
  struck,
  struckQris,
  struckBrizzi
}

class Progress {
  static String commit = "6";
  static String assign = "2";
  static String visit = "1";
  static String start = "4";
  static String pause = "3";
  static String retur = "7";
  static String end = "0";
}
