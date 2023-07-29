import 'package:flutter/material.dart';
import '../utils/ep_colors.dart';

class EPTextField extends StatefulWidget {
  const EPTextField({
    super.key,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.obscureText,
  });

  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool? obscureText;

  @override
  State<EPTextField> createState() => _EPTextFieldState();
}

class _EPTextFieldState extends State<EPTextField> {
  bool obscureText = false;
  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        filled: true,
        fillColor: EPColors.kWhiteColor,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        isDense: true,
        labelText: widget.hintText ?? 'Email',
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        suffixIcon: widget.obscureText != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                  obscureText == false
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: EPColors.kPrimaryColor,
                ),
              )
            : null,
      ),
      autocorrect: false,
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }
}
