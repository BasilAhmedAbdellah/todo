import 'package:flutter/material.dart';
typedef Validator = String?Function(String?);
class CustomFormField extends StatelessWidget {
  String hint;
  TextInputType keyboardtype;
  bool passwordtext;
  Validator? validator;
  TextEditingController? controller;
  int lines;
   CustomFormField({
     required this.hint,
     this.keyboardtype=TextInputType.text,
     this.passwordtext=false,
     this.validator,
     this.controller,
     this.lines=1
   });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: lines,
      minLines: lines,
      controller: controller,
      validator: validator,
      keyboardType: keyboardtype ,
      obscureText:passwordtext ,
      decoration: InputDecoration(
        labelText: hint,
      ),
    );
  }
}
