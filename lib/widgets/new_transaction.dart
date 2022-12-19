// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:expense_tracker/widgets/adaptive_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // const NewTransaction({super.key});
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // fetching user input
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  // for date picker
  // nullsafety; ? added
  DateTime? _selectedDate;
  //the below is the updated way of handling the datepicker; just initialize the _selectedDate as following:
  // var _selectedDate = DateTime.now();

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      // submitting date
      _selectedDate,
    );

// this bring a new input to the top and closes the modal sheet after input
    Navigator.of(context).pop();
  }

  // method that shows date picker; dioesnt need to return anyting
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
      // then method allows to provide a function which is executed once the future resultys to a value; once theuser picks a date
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
      // _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // CupertinoTextField(placeholder: ,),
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (value) {
                //   titleInput = value;
                // },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                // change the smount input
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                // for ios keyboardType: TextInputType.numberWithOptions(decimal:true), othrrs just .number
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              // datepicker
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date added till now'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
                    ),
                    AdaptiveFlatButton('Choose Date', _presentDatePicker)
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: _submitData,
                // color: Colors.purple,
                // print(titleController.text);
                // print(titleInput);
                // print(amountInput);

                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor:
                      Theme.of(context).textTheme.button?.color, // foreground
                ),
                child: const Text('Add Transaction'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
