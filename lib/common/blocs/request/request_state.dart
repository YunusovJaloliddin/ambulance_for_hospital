part of 'request_bloc.dart';

abstract class RequestState extends Equatable {
  const RequestState();

  @override
  List<Object?> get props => [];
}

class RequestInitial extends RequestState {}

class RequestSuccess extends RequestState {}
class RequestProgress extends RequestState {}

class RequestError extends RequestState {
  final String? message;

  const RequestError(this.message);
}
