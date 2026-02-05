enum COLLECTIONS { user }

enum RequestStatus { initial, loading, error, success }

enum AuthStatus { authenticated, unauthenticated }

enum PhoneNumberZone {
  vn('vn'),
  us("us");

  final String value;
  const PhoneNumberZone(this.value);

  static PhoneNumberZone? fromString(String value) {
    switch (value) {
      case 'vn':
        return PhoneNumberZone.vn;
      case 'us':
        return PhoneNumberZone.us;
      default:
        return null;
    }
  }

  String get displayText {
    switch (this) {
      case PhoneNumberZone.vn:
        return "VN";
      case PhoneNumberZone.us:
        return "US";
    }
  }

  String get flagImage {
    switch (this) {
      case PhoneNumberZone.vn:
        return 'assets/vn_flag.png';
      case PhoneNumberZone.us:
        return 'assets/us_flag.webp';
    }
  }

  String get displayNumberZone {
    switch (this) {
      case PhoneNumberZone.vn:
        return "+84";
      case PhoneNumberZone.us:
        return "+01";
    }
  }
}
