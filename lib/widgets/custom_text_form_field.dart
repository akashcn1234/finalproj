import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  final String hintText;
 
  final String? errorText;
  final TextInputType? input;
  final Widget ? suffixIcon;
  final bool ? obscureText;
  final Color ? borderColor;
  String? Function(String?)? validator;
  void  Function(String?)? onSaved;
  final  String  ? initialValue;

   CustomFormTextField({
    Key? key,
    required this.hintText,

    this.input,
    this.errorText,
    this.suffixIcon,
    this.obscureText,
    this.borderColor,
    this.validator,
    this.onSaved,
    this.initialValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide:  BorderSide(
        color: borderColor?? Colors.white,
      ),
    );
    return TextFormField(
     
      validator: validator,
      onSaved: onSaved,
      keyboardType: input,
      obscureText: obscureText??false,

      initialValue:  initialValue,
    
      decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          border: outlineInputBorder,
          errorText: errorText,
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.w400),


          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.red))),
    );
  }
}