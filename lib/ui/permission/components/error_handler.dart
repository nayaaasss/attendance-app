import 'package:attendace_app/ui/permission/components/snack_bar.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static void handleError(BuildContext context, dynamic error) {
    if (error is PermissionDeniedException) { //kalau misalkan errornya denied maka akan muncul snackbar
     SnackBarComponent.showSnackBar(
      context,
      "permission Denied",
      isError: true,
      );
    } else { //kalau errornya bukan denied maka akan muncul snackbar dengan pesan errornya
      SnackBarComponent.showSnackBar(
      context,
      error,
      isError: true
      );
    }
    Navigator.of(context).pop();
  }
}

class PermissionDeniedException implements Exception{ //jd Exception(error atau problem) di implement oleh permissioDenied
  final String message;
  //proses pembuatan placeholder dri sebua exception/error
  PermissionDeniedException([this.message = ""]);

  //kalau misalkan dia sdh jelas 
  @override
  String toString() => message.isEmpty ? "Permission Denied" : message; //setelah tanda tny itu yg pertama terpenuhi yg kedua itu tdk terpenuhi
}