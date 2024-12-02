import 'package:flutter/material.dart';

class customTextFiled extends StatelessWidget {
   customTextFiled({super.key,this.hintText,this.onChanged});
String? hintText;
Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data){
        if(data!.isEmpty) return 'Field is required';
        return null;
      },
      onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle:const TextStyle(color:Colors.white) ,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              border: const OutlineInputBorder( 
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          );
  }
}