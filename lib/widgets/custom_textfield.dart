import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  BuildContext context;
  String label;
  FocusNode node;
  TextEditingController controller;
  TextInputType type;

  CustomTextField(
      {this.context, this.label, this.node, this.controller, this.type});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      focusNode: widget.node,
      controller: widget.controller,
      obscureText: widget.type == TextInputType.visiblePassword ? true : false,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          letterSpacing: 1.5,
        ),
        hintText: widget.label,
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
      keyboardType: widget.type,
      style: new TextStyle(
          fontFamily: "Poppins",
          color: widget.node.hasFocus ? Colors.blueAccent : Colors.grey),
    );
  }
}
