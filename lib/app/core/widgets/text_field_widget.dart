import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytix/app/core/values/app_values.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({super.key,
    this.controller,
    this.focusNode,
    this.labelText,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.readOnly = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.onTap,
    this.onFieldSubmitted,
    this.validator,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final bool readOnly;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String? value)? validator;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        top: AppValues.padding
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: focusNode,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        obscureText: widget.obscureText,
        readOnly: widget.readOnly,
        cursorWidth: 1.0,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        validator: widget.validator,
        onTap: widget.onTap,
        onFieldSubmitted: widget.onFieldSubmitted,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppValues.smallRadius),
            borderSide: BorderSide(
              color: theme.disabledColor
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppValues.smallRadius),
            borderSide: const BorderSide(
              width: 1.5
            )
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppValues.smallRadius),
            borderSide: BorderSide(
              width: 1.5,
              color: theme.colorScheme.error
            )
          ),
          prefixText: widget.prefixText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          counterText: ""
        ),
      ),
    );
  }
}
