import 'package:flutter/material.dart';
import '../widgets/login_form.dart';
import '../widgets/register_form.dart';

class UserForm extends StatefulWidget {
  final void Function(String, String) doLogin;
  final void Function(String, String, String) doRegister;

  UserForm({
    Key? key,
    required this.doLogin,
    required this.doRegister,
  }) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  bool showLoginForm = true;

  void switchForm() {
    setState(() {
      showLoginForm = !showLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: showLoginForm
          ? LoginForm(widget.doLogin, switchForm)
          : RegisterForm(widget.doRegister, switchForm),
    );
  }
}
