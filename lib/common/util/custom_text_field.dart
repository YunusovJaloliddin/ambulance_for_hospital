import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? textEditingController;
  final bool count;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.textEditingController,
    required this.count,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode focusNode=FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  String? validate(validate){
    if(validate=="" || validate == null){
      return "Incorrect";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validate,
      focusNode: focusNode,
      keyboardType: widget.count?TextInputType.number:TextInputType.text,
      controller: widget.textEditingController,
      onTapOutside: (event) => focusNode.unfocus(),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 2, color: Colors.red),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 2),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 2, color: Colors.red),
        ),
        filled: true,
        fillColor: const Color(0x4D9E9E9E),
        focusColor: Colors.grey,
        labelText: widget.hintText,
        labelStyle: const TextStyle(fontSize: 18),
      ),
      textInputAction: TextInputAction.next,
    );
  }
}
