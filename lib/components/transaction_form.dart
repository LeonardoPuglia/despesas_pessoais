import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Function(String, double) onSubmit;

  TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _onSubmitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0;

    if (title.isEmpty || value <= 0) return;

    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        // ignore: prefer_const_literals_to_create_immutables
        child: Column(children: [
          TextField(
            controller: titleController,
            onSubmitted: (_) => _onSubmitForm(),
            decoration: const InputDecoration(
              labelText: 'Título',
            ),
          ),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: valueController,
            onSubmitted: (_) => _onSubmitForm(),
            decoration: const InputDecoration(
              labelText: 'Valor (R\$)',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _onSubmitForm(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  textStyle: const TextStyle(
                    color: Colors.purple,
                  ),
                ),
                child: const Text('Nova Transação'),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
