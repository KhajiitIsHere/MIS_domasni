import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  final void Function(String, String, String) doRegister;
  final void Function() switchLogin;
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  RegisterForm(this.doRegister, this.switchLogin, {Key? key}) : super(key: key);

  void loginHandler() {
    final username = usernameController.value.text;
    final password = passwordController.value.text;
    final phoneNumber = phoneNumberController.value.text;
    final repeatPassword = repeatPasswordController.value.text;

    if (username.trim().isEmpty ||
        phoneNumber.trim().isEmpty ||
        password.trim().isEmpty ||
        repeatPassword.trim().isEmpty ||
        password != repeatPassword) {
      return;
    }

    doRegister(username, password, phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone number'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: repeatPasswordController,
              decoration: const InputDecoration(labelText: 'Repeat Password'),
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(onPressed: switchLogin, child: const Text('Login')),
              ElevatedButton(
                  onPressed: loginHandler, child: const Text('Register')),
            ])
          ],
        ),
      ),
    );
  }
}
