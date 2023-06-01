// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function(String, double, DateTime) onSubmit;

  // ignore: prefer_const_constructors_in_immutables
  TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _onSubmitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;

    if (title.isEmpty || value <= 0) return;

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _selectedDate = pickedDate;
      });
    });
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
            controller: _titleController,
            onSubmitted: (_) => _onSubmitForm(),
            decoration: const InputDecoration(
              labelText: 'Título',
            ),
          ),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: _valueController,
            onSubmitted: (_) => _onSubmitForm(),
            decoration: const InputDecoration(
              labelText: 'Valor (R\$)',
            ),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'Nenhuma data selecionada'
                        : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate!)}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: _showDatePicker,
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  onPressed: () => _onSubmitForm(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    textStyle: const TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                  child: const Text(
                    'Nova Transação',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
