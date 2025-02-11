import 'package:attendace_app/services/data_service.dart';
import 'package:attendace_app/ui/history/components/attendance_card.dart';
import 'package:attendace_app/ui/history/components/delete_dialog.dart';
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
      body: StreamBuilder( //untuk membuat ui kita agar termanage dengan baik
        stream: dataService.dataCollection.snapshots(),//snapshots untuk memanage dan menghandle dri data" yg sudah kita ambil
         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) { //jika snapshot kita gapunya data, dia akan mereturn teks
            return const Center(
              child: Text("There is no data.")
            );
          }

          final data = snapshot.data!.docs; //documen adalah reprsentasi semua data yg ada di firbase firestor
          //ini jika mempunyai data
          //membuat data secara list
          return ListView.builder(
            itemCount: data.length, //untuk menghitung jumlah data yg ada di firbase, length itu jumlah datanya berapa
            itemBuilder: (context, index) {
              return AttendanceHistoryCard(
                data: data[index].data() as Map<String, dynamic>, //untuk mendefinisikan data yg akan muncul di UI berdasarkan index atau posisi yg ada di db
                onDelete: () {
                  showDialog(
                    context: context, 
                    builder: (context) => DeleteDialog(
                      documentId: data[index].id, //untuk menjadikan index sbg id dri data yg ada di db
                      datacollection: dataService.dataCollection,
                      //digunakan untuk memperbarui state setelah terjadi penghapusa data dri db
                      onConfirm: () {
                        setState(() {
                          dataService.deleteData(data[index].id); //memperbarui index jika si user menghapus data
                          Navigator.pop(context);
                        });
                      },
                      )
                    );
                }
                );
            },
          );
         }
        )
    );
  }
}