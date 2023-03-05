import 'package:domasno2/model/user.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  final User user;
  final void Function() openHomePage;
  final void Function() logout;
  final void Function(String) addAddress;

  AccountPage({
    required this.user,
    required this.openHomePage,
    required this.logout,
    required this.addAddress,
    Key? key,
  }) : super(key: key);

  final addressController = TextEditingController();

  void handleAddAddress() {
    final address = addressController.value.text;

    if (address.trim().isEmpty) {
      return;
    }

    addAddress(address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: [
          TextButton(
            onPressed: logout,
            child: const Text('Log out'),
          )
        ],
        leading: IconButton(
          onPressed: openHomePage,
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Text(
                  user.name,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ),
            Card(
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Text(
                  user.phoneNumber,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ...user.addresses
                .map((e) => Card(
                      elevation: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        child: Text(e),
                      ),
                    ))
                .toList(),
            Card(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Column(children: [
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'New Address'),
                  ),
                  TextButton(
                    onPressed: handleAddAddress,
                    child: const Text('Add address'),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
