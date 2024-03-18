import 'package:ambulance_for_hospital/common/controller/store_provider.dart';
import 'package:ambulance_for_hospital/common/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../common/models/booking.dart';
import '../../../../common/models/clinic_model.dart';
import '../location/location.dart';

class Accepted extends StatefulWidget {
  const Accepted({super.key});

  @override
  State<Accepted> createState() => _AcceptedState();
}

class _AcceptedState extends State<Accepted> {
  IHomeRepository homeRepository = HomeRepository();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: homeRepository.getAllBooking(context.read<StoreProvider>().name),
      builder: (context, snapshot) {
        ClinicModel clinicModel = ClinicModel.fromJson((snapshot.data?.value ??
            {
              "name": "",
              "address": "",
              "token": "",
              "answerTime": 0,
              'stars': 0,
              'bookingHistory': []
            }) as Map<Object?, Object?>);
        List<Booking> booking = clinicModel.bookingHistory.where((e) {
          return e.status == Status.accept;
        }).toList();
        return ListView.separated(
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              Geolocator.requestPermission();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationScreen(booking: booking[index]),
                ),
              );
            },
            tileColor: Colors.greenAccent,
            title: Text(booking[index].userModel.name),
            subtitle: Text(booking[index].address),
            trailing: Text(
                "${"${booking[index].answerTime ~/ 60}".padLeft(2, "0")} : ${"${booking[index].answerTime % 60}".padLeft(2, "0")}"),
          ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: booking.length,
        );
      },
    );
  }
}
