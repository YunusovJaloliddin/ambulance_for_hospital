import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/blocs/request/request_bloc.dart';
import '../../../../common/controller/store_provider.dart';
import '../../../../common/models/booking.dart';
import '../../../../common/models/clinic_model.dart';
import '../../../../common/repository/home_repository.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  IHomeRepository homeRepository = HomeRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream:
              homeRepository.getAllBooking(context.read<StoreProvider>().name),
          builder: (context, snapshot) {
            ClinicModel clinicModel =
                ClinicModel.fromJson((snapshot.data?.value ??
                    {
                      "name": "",
                      "address": "",
                      "token": "",
                      "answerTime": 0,
                      'stars': 0,
                      'bookingHistory': []
                    }) as Map<Object?, Object?>);
            List<Booking> booking = clinicModel.bookingHistory.where((e) {
              return e.status == Status.request;
            }).toList();
            return ListView.separated(
              itemBuilder: (context, index) => ListTile(
                tileColor: Colors.redAccent,
                title: Text(booking[index].userModel.name),
                subtitle: Text(booking[index].address),
                trailing: BlocProvider(
                  create: (context) =>
                      RequestBloc(homeRepository: homeRepository),
                  child: BlocBuilder<RequestBloc, RequestState>(
                    builder: (context, state) {
                      if (state is RequestProgress) {
                        return const CircularProgressIndicator();
                      } else {
                        return IconButton(
                          icon: const Icon(
                            Icons.arrow_circle_right,
                            color: Colors.greenAccent,
                          ),
                          iconSize: 35,
                          onPressed: () => context.read<RequestBloc>().add(
                                RequestToAccept(
                                  clinicModel: clinicModel,
                                  booking: booking[index],
                                ),
                              ),
                        );
                      }
                    },
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: booking.length,
            );
          },
        ),
      ),
    );
  }
}
