import 'package:flutter/material.dart';

class SnackBarComponent {
  //stastic model --> untuk mempertahankan value dripda function yg dipanggil(valuenya ttp)
  //ini mau membuat snackbar yg errornya sesuai dg kejadian sprti try catch 
  //stu function yg ini di pertahankan berkali-kali
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) { 
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            )
            )
        ],
      ),
      backgroundColor: isError ? Colors.red : Colors.blueGrey,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      ));
  }
}