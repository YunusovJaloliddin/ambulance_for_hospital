import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/clinic_model.dart';
import '../repository/home_repository.dart';
import 'storage.dart';

class StoreProvider extends ChangeNotifier {
  ClinicModel? clinicModel;
  String name="Dedan mahallasi";

  void setName(String path){
    name=path;
    notifyListeners();
  }

  void saveClinic() async {
    IHomeRepository homeRepository = HomeRepository();
    await $secureStorage.write(
      key: StorageKeys.clinic.key,
      value: jsonEncode(clinicModel),
    );
    await homeRepository
        .updateClinic(clinicModel ?? ClinicModel(name: "", address: "",token: ""));
  }

  void setClinic(ClinicModel clinic) async {
    clinicModel = clinic;
    await $secureStorage.write(
      key: StorageKeys.clinic.key,
      value: jsonEncode(clinicModel),
    );
    notifyListeners();
  }
  void updateClinic(ClinicModel clinic) async {
    clinicModel=clinic;
    IHomeRepository homeRepository = HomeRepository();
    await $secureStorage.write(
      key: StorageKeys.clinic.key,
      value: jsonEncode(clinicModel),
    );
    await homeRepository
        .updateClinic(clinicModel ?? ClinicModel(name: "", address: "",token: ""));
    notifyListeners();
  }

  void getClinic() async {
    String? json = await $secureStorage.read(key: StorageKeys.clinic.key);
    if (json != null) {
      clinicModel = ClinicModel.fromJson(jsonDecode(json));
      name=clinicModel?.name??"";
    }
    notifyListeners();
  }
}
