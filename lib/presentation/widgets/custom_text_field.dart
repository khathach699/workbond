import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workbond/core/utils/responsive.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText; // Đổi thành non-nullable
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final VoidCallback? onTap; // Đổi thành VoidCallback để rõ ràng hơn
  final VoidCallback? onSuffixIconTap;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onSuffixIconTap,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
    if (widget.onSuffixIconTap != null) {
      widget.onSuffixIconTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: responsive.fontSize(14)),
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                icon: Icon(
                  _obscureText ? widget.suffixIcon : Icons.visibility_off,
                ),
                onPressed: () {
                  print('Suffix icon pressed for ${widget.hintText}');
                  _toggleObscureText();
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      validator: widget.validator,
      onChanged: (value) {
        print('TextField changed: ${widget.hintText}, value: $value');
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      onTap: () {
        print('TextField tapped: ${widget.hintText}');
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onFieldSubmitted: (value) {
        print('TextField submitted: ${widget.hintText}, value: $value');
      },
    );
  }
}
