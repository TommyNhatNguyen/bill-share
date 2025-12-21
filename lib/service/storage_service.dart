import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  StorageService();

  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  Future<Map<String, String>?> readAll() async {
    return await storage.readAll();
  }

  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await storage.deleteAll();
  }

  Future<void> write(String key, String value) async {
    await storage.write(key: key, value: value);
  }
}
