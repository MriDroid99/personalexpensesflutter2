import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BottomSheetWidget extends StatefulWidget {
  final Function(String id, String title, double price, DateTime date) addItem;
  const BottomSheetWidget(this.addItem, {Key? key}) : super(key: key);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  DateTime? _selectedDate;
  var _titleController = TextEditingController();
  var _priceController = TextEditingController();

  void openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedDate == null
                      ? 'Not Date Selected'
                      : '${DateFormat.yMMMd().format(_selectedDate!)}'),
                  TextButton(
                      onPressed: openDatePicker, child: Text('Choose Date'))
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.addItem(
                      DateTime.now().toString(),
                      _titleController.text,
                      double.parse(_priceController.text),
                      _selectedDate!,
                    );
                  },
                  child: Text('Add Item'))
            ],
          ),
        ),
      ),
    );
  }
}
