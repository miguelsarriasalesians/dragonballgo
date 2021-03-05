import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  BuildContext context;
  String label;
  TextInputType type;
  final node = FocusNode();
  TextEditingController controller;

  CustomTextField({this.context, this.label, this.type, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        if (this.type == TextInputType.datetime)
          showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now())
              .then((value) {
            if (value != null) {
              final str = value.toIso8601String();
              final newVal = str.substring(0, str.indexOf("T"));
              print(newVal);
              controller.value = TextEditingValue(
                  text: newVal,
                  selection: TextSelection.fromPosition(
                    TextPosition(offset: newVal.length),
                  ));
            }
          });
      },
      textAlign: TextAlign.center,
      focusNode: FocusNode(),
      controller: controller,
      obscureText: this.type == TextInputType.visiblePassword ? true : false,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          letterSpacing: 1.5,
        ),
        hintText: this.label,
        focusColor: Colors.black,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      keyboardType: this.type,
      style: new TextStyle(
          fontFamily: "Poppins",
          color: this.node.hasFocus ? Colors.blueAccent : Colors.grey),
    );
  }
}
