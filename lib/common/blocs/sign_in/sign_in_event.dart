part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class SignInRequired extends SignInEvent {
  final String name;
  final String address;

  const SignInRequired({
    required this.name,
    required this.address,
  });

  @override
  List<Object?> get props => [name, address];
}

class SignOutRequired extends SignInEvent {
  const SignOutRequired();
}
