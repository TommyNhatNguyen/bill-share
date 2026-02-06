enum COLLECTIONS { user }

enum RequestStatus { initial, loading, error, success }

enum AuthStatus { authenticated, unauthenticated }

enum PhoneCode {
  vn('vn'),
  us("us");

  final String value;
  const PhoneCode(this.value);

  static PhoneCode? fromString(String value) {
    switch (value) {
      case 'vn':
        return PhoneCode.vn;
      case 'us':
        return PhoneCode.us;
      default:
        return null;
    }
  }

  String get displayText {
    switch (this) {
      case PhoneCode.vn:
        return "VN";
      case PhoneCode.us:
        return "US";
    }
  }

  String get flagImage {
    switch (this) {
      case PhoneCode.vn:
        return 'assets/vn_flag.png';
      case PhoneCode.us:
        return 'assets/us_flag.webp';
    }
  }

  String get displayNumberZone {
    switch (this) {
      case PhoneCode.vn:
        return "+84";
      case PhoneCode.us:
        return "+01";
    }
  }
}
