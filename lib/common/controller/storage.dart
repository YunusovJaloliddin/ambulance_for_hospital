import 'package:flutter_secure_storage/flutter_secure_storage.dart';


FlutterSecureStorage $secureStorage= const FlutterSecureStorage();

enum StorageKeys {
  clinic("clinic");

  const StorageKeys(this.key);

  final String key;
}