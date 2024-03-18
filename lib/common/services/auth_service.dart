import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/clinic_model.dart';
import '../repository/home_repository.dart';
import 'database_service.dart';

sealed class AuthService {
  static final auth = FirebaseAuth.instance;

  static Future<bool> registration(
    String name,
    String address,
  ) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: "${address.split(",").last.replaceAll(" ", "").toLowerCase()}@gmail.com",
        password: name,
      );
      if (credential.user != null) {
        await credential.user!.updateDisplayName(name);
        await DatabaseService.storeClinic(name, address);
      }
      return credential.user != null;
    } catch (e) {
      debugPrint("ERROR: $e");
      return false;
    }
  }

  static Future<ClinicModel?> login(
    String name,
    String address,
  ) async {
    try {
      IHomeRepository userRepository = HomeRepository();
      final credential = await auth.signInWithEmailAndPassword(
        email: "${address.split(",").last.replaceAll(" ", "").toLowerCase()}@gmail.com",
        password: name,
      );
      if (credential.user != null) {
        ClinicModel? clinicModel=await userRepository.readClinic(name);
        return clinicModel;
      }
      return null;
    } catch (e) {
      debugPrint("ERROR: $e");
      return null;
    }
  }

  static Future<bool> logOut() async {
    try {
      await auth.signOut();
      return true;
    } catch (e) {
      debugPrint("ERROR: $e");
      return false;
    }
  }

  static Future<bool> deleteAccount() async {
    try {
      if (auth.currentUser != null) {
        await auth.currentUser!.delete();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("ERROR: $e");
      return false;
    }
  }

  static User? get user => auth.currentUser;
}
