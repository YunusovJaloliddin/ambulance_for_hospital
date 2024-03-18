import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../controller/storage.dart';
import '../models/clinic_model.dart';
import '../services/database_service.dart';

abstract interface class IHomeRepository {
  Stream<User?> get user;

  Stream<DataSnapshot> getAllBooking(String path);

  Future<List<ClinicModel>> getClinics();

  DatabaseReference queryClinic(String path);

  Future<ClinicModel?> readClinic(String address);

  Future<void> updateClinic(ClinicModel clinicModel);
}

class HomeRepository implements IHomeRepository {
  HomeRepository() : _service = DatabaseService();

  final DatabaseService _service;

  @override
  Stream<DataSnapshot> getAllBooking(String path) =>
      _service.getAllBooking(path).transform(
        StreamTransformer<DatabaseEvent, DataSnapshot>.fromHandlers(
          handleData: (data, sink) {
              sink.add(data.snapshot);
          },
        ),
      );

  @override
  DatabaseReference queryClinic(String path) => _service.queryFromPath(path);

  @override
  Future<ClinicModel?> readClinic(String name) async {
    ClinicModel? clinicModel = await DatabaseService.readClinic(name);
    if (clinicModel != null) {
      await $secureStorage.write(
          key: StorageKeys.clinic.key, value: jsonEncode(clinicModel));
    }
    return clinicModel;
  }

  @override
  Future<void> updateClinic(ClinicModel clinicModel) async {
    await _service.updateClinic(clinicModel);
  }

  @override
  Future<List<ClinicModel>> getClinics() async {
    return await _service.getClinics();
  }

  @override
  Stream<User?> get user {
    final firebaseAuth = FirebaseAuth.instance;
    return firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser;
      return user;
    });
  }
}
