import 'package:attendace_app/services/data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceHistoryScreenState extends StatefulWidget {
  const AttendanceHistoryScreenState({super.key});

  @override
  State<AttendanceHistoryScreenState> createState() => _AttendanceHistoryScreenStateState();
}

class _AttendanceHistoryScreenStateState extends State<AttendanceHistoryScreenState> {
  final DataService dataService = DataService(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Attendance History",
        )
      ),
      body: StreamBuilder( //untuk membuat ui ki agar termanage dengan baik
        stream: dataService.dataCollection.snapshots(),//snapshots untuk memanage dan menghandle dri data" yg sudah kita ambil
         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) { //jika snapshot kita gapunya data, dia akan mereturn teks
            return const Center(
              child: Text("There is no data.")
            );
          }

          final data = snapshot.data!.docs; //documen adalah reprsentasi semua data yg ada di firbase firestor
          return ListView.builder(
            itemCount: data.length, //untuk menghitung jumlah data yg ada di firbase, length itu jumlah datanya berapa
            itemBuilder: (context, index) {
              //put attendance card UI here
            },
          );
         }
        )
    );
  }
}