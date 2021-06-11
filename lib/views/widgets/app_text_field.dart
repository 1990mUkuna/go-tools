import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool hasBackTap;
  final String labelText;
  final List<String> autofillHint;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final bool isMultiline;
  final List<TextInputFormatter> inputFormatters;
  final Icon leadingIcon;
  final Function onTap;
  final bool isReadOnly;
  final Function leadingAction;

  AppTextField({
    @required this.controller,
    @required this.hintText,
    this.labelText,
    this.autofillHint,
    this.hasBackTap = false,
    this.leadingAction,
    this.textInputType,
    this.textCapitalization = TextCapitalization.sentences,
    this.isMultiline = false,
    this.inputFormatters,
    this.leadingIcon,
    this.onTap,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Material(
      child: TextFormField(
        onTap: onTap,
        autofillHints: autofillHint,
        style: theme.bodyText1.copyWith(fontSize: 16),
        controller: controller,
        cursorColor: Theme.of(context).primaryColor,
        keyboardType: textInputType,
        textCapitalization: textCapitalization,
        maxLines: isMultiline ? 8 : 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Field cannot be left empty";
          }
          return null;
        },
        readOnly: isReadOnly,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          icon: leadingIcon != null
              ? IconButton(
                  icon: leadingIcon,
                  onPressed: () {
                    if (leadingAction != null) leadingAction();
                  })
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 25.0,
            horizontal: 10.0,
          ),
          // hintText: hintText,
          hintStyle: theme.bodyText1.copyWith(
            fontSize: 16,
            color: Color(0xFF2B2B2B),
          ),
          border: InputBorder.none,
          labelText: hintText,
          filled: true,
          fillColor: Color(0xFFf4f4f4),
        ),
      ),
    );
  }
}
