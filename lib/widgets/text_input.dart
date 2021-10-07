import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController _nameController;
  final String label;
  final bool isPassword;
  const TextInput({
    Key? key,
    required TextEditingController controller,required this.label,required this.isPassword,
  }) : _nameController = controller, super(key: key);



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color:Color(0xff634310),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,

            ),
            focusColor: const Color(0xff634310),
              enabledBorder: InputBorder.none,
          ),
          obscureText: isPassword,
        ),
      ),
    );
  }
}
