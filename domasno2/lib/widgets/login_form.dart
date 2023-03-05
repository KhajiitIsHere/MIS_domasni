import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final void Function(String, String) doLogin;
  final void Function() switchRegister;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginForm(this.doLogin, this.switchRegister, {Key? key}) : super(key: key);

  void loginHandler() {
    final username = usernameController.value.text;
    final password = passwordController.value.text;

    if (username.trim().isEmpty || password.trim().isEmpty) {
      return;
    }

    doLogin(username, password);
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
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              TextButton(onPressed: switchRegister, child: const Text('Register')),
              ElevatedButton(onPressed: loginHandler, child: const Text('Login')),
            ])
          ],
        ),
      ),
    );
  }
}
