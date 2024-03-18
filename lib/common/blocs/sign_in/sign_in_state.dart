part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState {}

class SignInSuccess extends SignInState {
  final ClinicModel clinicModel;
  const SignInSuccess(this.clinicModel);
}

class SignInFailure extends SignInState {
  final String? message;

  const SignInFailure({this.message});
}

class SignInProcess extends SignInState {}
