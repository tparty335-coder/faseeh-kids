import 'dart:io';

/// Lightweight connectivity checker
/// Uses dart:io to check internet access without additional packages
class ConnectivityService {
  ConnectivityService._();

  static final ConnectivityService _instance = ConnectivityService._();

  /// Singleton instance
  static ConnectivityService get instance => _instance;

  /// Check if device has internet connectivity
  /// Returns true if DNS lookup succeeds
  Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } on Exception catch (_) {
      return false;
    }
  }
}
