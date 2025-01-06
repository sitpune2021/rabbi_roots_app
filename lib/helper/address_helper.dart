import 'package:shared_preferences/shared_preferences.dart';

class AddressHelper {
  static const String _addressKey = 'user_address';
  static const String _addressTypeKey = 'address_type';

  // Save the user address to shared preferences
  static Future<void> saveUserAddress(
      String address, String addressType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_addressKey, address);
    await prefs.setString(_addressTypeKey, addressType);
  }

  // Get the user address from shared preferences
  static Future<Map<String, String?>> getUserAddressFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    String? address = prefs.getString(_addressKey);
    String? addressType = prefs.getString(_addressTypeKey);
    return {'address': address, 'addressType': addressType};
  }

  // Remove the user address from shared preferences
  static Future<void> removeUserAddress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_addressKey);
    await prefs.remove(_addressTypeKey);
  }
}
