import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/clinic_model.dart';
import '../../services/auth_service.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      try {
        ClinicModel? clinicModel=await AuthService.login(event.name, event.address);
        if(clinicModel != null){
          emit(SignInSuccess(clinicModel));
        }
      } catch (e) {
        log(e.toString());
        emit(SignInFailure(message: e.toString()));
      }
    });
    on<SignOutRequired>((event, emit) async {
      await AuthService.logOut();
    });
  }
}
