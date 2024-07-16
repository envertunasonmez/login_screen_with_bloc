import 'package:flutter/material.dart';

import 'login_button.dart';
import 'password_textfield.dart';
import 'username_textfiedl.dart';

class FormWidget extends StatelessWidget {
  FormWidget({super.key});
  final GlobalKey _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const UserNameTextField(),
          const PasswordTextField(),
         const  SizedBox(
            height: 15,
          ),
          LoginButton(
            formKey: _formKey,
          ),
        ],
      ),
    );
  }
}
