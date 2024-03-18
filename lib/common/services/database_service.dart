import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import '../controller/storage.dart';
import '../models/clinic_model.dart';
import 'notification_service.dart';

class DatabaseService {
  static final db = FirebaseDatabase.instance;

  Stream<DatabaseEvent> getAllBooking(String path) =>
      db.ref(Folder.clinic).child(path).onValue.asBroadcastStream();

  DatabaseReference queryFromPath(String path) => db.ref(Folder.clinic).child(path).child("booking");

  Future<void> updateClinic(ClinicModel clinicModel) {
    return db
        .ref(Folder.clinic)
        .child(clinicModel.name)
        .update(clinicModel.toJson());
  }

  static Future<bool> storeClinic(
    String name,
    String address,
  ) async {
    try {
      final folder = db.ref(Folder.clinic).child(name);

      NotificationService notificationService = NotificationService();
      await notificationService.generateToken();

      final clinic = ClinicModel(
          name: name,
          address: address,
          token: notificationService.fcmTocen ?? "");
      await folder.set(clinic.toJson());
      await $secureStorage.write(
          key: StorageKeys.clinic.key, value: jsonEncode(clinic));
      return true;
    } catch (e) {
      debugPrint("DB ERROR: $e");
      return false;
    }
  }

  static Future<ClinicModel?> readClinic(String name) async {
    try {
      final data = await db.ref(Folder.clinic).child(name).get();
      final clinic = ClinicModel.fromJson(
          jsonDecode(jsonEncode(data.value)) as Map<String, dynamic>);
      return clinic;
    } catch (e) {
      debugPrint("DB ERROR: $e");
      return null;
    }
  }

  Future<List<ClinicModel>> getClinics() async {
    try {
      final data = await db.ref(Folder.clinic).get();
      List<ClinicModel> clinics = [];
      for (final json in (data.value as Map).values) {
        final clinic = ClinicModel.fromJson(Map<String, Object?>.from(json));
        clinics.add(clinic);
      }
      return clinics;
    } catch (e) {
      debugPrint("DB ERROR: $e");
      return [];
    }
  }
}

sealed class Folder {
  static const clinic = "Clinic";
}
