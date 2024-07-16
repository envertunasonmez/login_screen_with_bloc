import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_screen_with_bloc/blocs/auth/login/login_event.dart';
import 'package:login_screen_with_bloc/repository/auth/login/login_repository.dart';
import 'package:login_screen_with_bloc/views/auth/form_submission_status.dart';

import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository? authRepo;

  LoginBloc({this.authRepo}) : super(const LoginState()) {
    on<LoginEvent>(
      (event, emit) async {
        await mapEventToState(event, emit);
      },
    );
  }

  Future mapEventToState(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginUsernameChanged) {
      emit(state.copyWith(username: event.username));
    } else if (event is LoginPasswordChanged) {
      emit(state.copyWith(password: event.password));
    } else if (event is LoginSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await authRepo?.login();
        emit(state.copyWith(formStatus: SubmissionsSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(exception: e)));
      }
    }
  }
}
