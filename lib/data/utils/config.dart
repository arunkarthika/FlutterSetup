class Config {
  static String appVersion = '0.0.1';
  static String apiVersion = 'v1';
  // URLs
  // static String baseUrl = 'http://httpstat.us/'; // for http response code testing
  static String stageserverUri = 'phalcon.sjhinfotech.com';
  static String liveserverUri = 'ugolive.sjhinfotech.com';
  static String serverUri = stageserverUri;
  static int port = 1883;
  static String liveUrl =
      'https://ugolive.sjhinfotech.com/blive_phalcon/api/v1/';
  static String stageUrl =
      'https://phalcon.sjhinfotech.com/blive_phalcon/api/v1/';
  static String domain = stageUrl;
  static const String SYSTEM_CHECK = 'system/check';
  // Header key
  static const String CONTENT_TYPE_KEY = 'Content-Type';
  static const String AUTH_TOKEN_KEY = 'auth-token';
  static const String ACCEPT_LANGUAGE_KEY = 'accept-language';
  static const String DEVICE_ID_KEY = 'device-id';

  // Header value
  static const String CONTENT_TYPE_JSON = 'application/json';
  static const String TZ_NAME_ASIA_KOLKATA = 'Asia/Kolkata';
  // HTTP CODE
  static const int SUCCESS_OK = 200;
  static const int BAD_REQUEST = 400;
  static const int UN_AUTHORIZED = 401;
  static const int ACCOUNT_DISABLED = 403;
  static const int INTERNAL_SERVER_ERROR = 500;
}
