import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_screen_with_bloc/blocs/auth/login/login_bloc.dart';
import 'package:login_screen_with_bloc/repository/auth/login/login_repository.dart';
import 'package:login_screen_with_bloc/views/auth/form_submission_status.dart';
import 'package:login_screen_with_bloc/views/auth/login/widgets/form_widget.dart';

import '../../../blocs/auth/login/login_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => LoginBloc(authRepo: context.read<LoginRepository>()),
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) =>
            previous.formStatus != current.formStatus,
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            return _showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormWidget(),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
