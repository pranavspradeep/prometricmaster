import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceService {
  static const String _deviceIdKey = 'unique_device_id';

  static Future<String?> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedId = prefs.getString(_deviceIdKey);
    if (storedId != null && storedId.isNotEmpty) {
      return storedId;
    }
    // Always generate a random UUID for a unique device ID
    String uuid = Uuid().v4();
    await prefs.setString(_deviceIdKey, uuid);
    return uuid;
  }
}
