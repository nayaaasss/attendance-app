import 'package:flutter/material.dart';

class FormBody extends StatelessWidget {
  const FormBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            //TODO: make yout own form body content
            "FORM BODY CONTENT"
          )
        ],
      ),
      );
  }
}