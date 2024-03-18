import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/booking.dart';
import '../../models/clinic_model.dart';
import '../../repository/home_repository.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final IHomeRepository homeRepository;

  RequestBloc({required this.homeRepository}) : super(RequestInitial()) {
    on<RequestToAccept>((event, emit) async {
      emit(RequestProgress());
      try{
        int indexThisBook =
            event.clinicModel.bookingHistory.lastIndexOf(event.booking);
        event.clinicModel.bookingHistory[indexThisBook].status = Status.accept;
        await homeRepository.updateClinic(event.clinicModel);
        emit(RequestSuccess());
      }catch(e){
        emit(RequestError(e.toString()));
      }
    });
  }
}
