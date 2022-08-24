import 'package:flutter/material.dart';

Widget defaultTextFormField({
  required String label,
  IconData? prefixIcon,
  EdgeInsets padding = const EdgeInsets.all(0.0),
  IconData? suffixIcon,
  bool obscure = false,
  TextInputType textInputType = TextInputType.text,
  TextEditingController? controller,
  VoidCallback? suffixOnPressed,
  FormFieldValidator<String>? validate,
}) =>
    Padding(
      padding: padding,
      child: TextFormField(
        // style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
          prefixIcon: (suffixIcon != null) ? Icon(prefixIcon) : null,
          labelText: label,
          border: const OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          suffixIcon: (suffixIcon != null)
              ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: suffixOnPressed,
                )
              : null,
        ),
        obscureText: obscure,
        keyboardType: textInputType,
        controller: controller,
        validator: validate,
      ),
    );
