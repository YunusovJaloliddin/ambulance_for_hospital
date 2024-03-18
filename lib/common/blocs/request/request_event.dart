part of 'request_bloc.dart';

class RequestEvent extends Equatable {
  const RequestEvent();

  @override
  List<Object?> get props => [];
}

class RequestToAccept extends RequestEvent {
  final ClinicModel clinicModel;
  final Booking booking;

  const RequestToAccept({required this.clinicModel, required this.booking});

  @override
  List<Object?> get props => [clinicModel, booking];
}
