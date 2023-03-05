import 'package:flutter/material.dart';

class SaveBurgerForm extends StatefulWidget {
  final void Function(String) onSave;

  const SaveBurgerForm(this.onSave, {Key? key}) : super(key: key);

  @override
  State<SaveBurgerForm> createState() => _SaveBurgerFormState();
}

class _SaveBurgerFormState extends State<SaveBurgerForm> {
  final nameController = TextEditingController();

  void saveHandler() {
    final name = nameController.value.text;

    if (name.trim().isEmpty) {
      return;
    }

    widget.onSave(name);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          ElevatedButton(
              onPressed: saveHandler, child: const Text('Save Burger'))
        ],
      ),
    );
  }
}
