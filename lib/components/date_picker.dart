import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class CustomDatePicker extends StatefulWidget {
  TextEditingController? controller;

  CustomDatePicker({Key? key, required this.controller}) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller, //editing controller of this TextField
        style: TextStyle(fontSize: 12, color: Colors.blue),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          prefixIconConstraints: BoxConstraints(minWidth: 23, maxHeight: 20),
          filled: true,
          labelText: 'Date',
          labelStyle: TextStyle(fontSize: 22, color: Colors.black),

          fillColor: Colors.white,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,

          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.calendar_today_outlined,
              color: Colors.red,
            ),
          ), //icon of text field
        ),
        readOnly: true, // when true user cannot edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2100),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Colors.red, // <-- SEE HERE
                      onPrimary: Colors.white, // <-- SEE HERE
                      onSurface: Colors.black, // <-- SEE HERE
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red, // button text color
                      ),
                    ),
                  ),
                  child: child!,
                );
              });

          if (pickedDate != null) {
            print(
                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
            String formattedDate =
                intl.DateFormat('EEEE, MMMM d, yyyy').format(pickedDate);
            print(
                formattedDate); //formatted date output using intl package =>  2021-03-16
            setState(() {
              widget.controller?.text =
                  formattedDate; //set output date to TextField value.
            });
          } else {}
        });
  }
}
