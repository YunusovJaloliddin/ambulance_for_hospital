import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/auth_service.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        bool login=await AuthService.registration(event.name, event.address);
        if(login){
          emit(SignUpSuccess());
        }
      } catch (e) {
        log(e.toString());
        emit(SignUpFailure());
      }
    });
  }
}
