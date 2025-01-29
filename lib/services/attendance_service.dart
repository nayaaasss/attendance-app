import 'package:attendace_app/ui/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//an entry point untuk submit attendance report
final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance');

Future<void> submitAttendanceReport(BuildContext context, String address, String name, String attendanceStatus, String timeStamp) async {
  showLoaderDialog(context);
  dataCollection.add( //kita mengumpulkan datanya
    {
      'address' : address,
      'name' : name,
      'description' : attendanceStatus,
      'time' : timeStamp
    }
  ).then((result) { //kemudian jika resultnya benar maka akan menjalankan in
    Navigator.of(context).pop();
    try {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.white,
            ),
            SizedBox(width: 10,),
            Text(
              "Attendance submitted successfully",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        backgroundColor: Colors.orangeAccent,
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        )
      );
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => HomeScreen())
        );

      //jika datanya error
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:  Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Text(
                "Ups, $e", // $e agar mendapatkan error spesifik
                style: TextStyle(color: Colors.white),
              )
              )
          ],
        ),
        backgroundColor: Colors.blueAccent,
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        ));
    }
  }).catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Ups, $error",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      backgroundColor: Colors.blueAccent,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      ));
      Navigator.of(context).pop();
  }) ;
}

void showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text("Cheking the data"),
        )
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context, 
    builder: (BuildContext context) { 
      return alert;
     }
  );
}