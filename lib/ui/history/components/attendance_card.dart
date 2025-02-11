import 'dart:math';
import 'package:attendace_app/ui/history/components/delete_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


//untuk menampung si history
class AttendanceHistoryCard extends StatelessWidget {
  final Map<String, dynamic> data; //map adlah pasangan key dan value
  final VoidCallback onDelete;

  const AttendanceHistoryCard({super.key, required this.data, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DeleteDialog(
          documentId: data["id"], 
          datacollection: FirebaseFirestore.instance.collection('attendance')
          );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  borderRadius: const BorderRadius.all(Radius.circular(10))
                ),
                child: Center(
                  child: Text(
                    data['name'][0].toUpperCase(), //name itu dari file attendance_service dri pasangan key value dan ini memanggil nama dri firstore dimulai dri 0 indexnya dan jd capslock
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            "Name",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            data['name'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14
                            )
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Attendance Status",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14
                          ),
                        ),
                        Text(
                          data['description'], //pemanggilannya jg dri key value dri attendance service
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          ),
      ),
    );
  }
}