//sebuah nontifikasi dalam bntuk dialog atau bentuk pop up notifikasi
//ini user yg menggunakannya

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String documentId;
  final CollectionReference datacollection;

  const DeleteDialog({super.key, required this.documentId, required this.datacollection, Null Function()? onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Delete Data",
        style: TextStyle(
          fontSize: 18,
          color: Colors.black
        ),
      ),
      content: const Text(
        "Are you sure you want to delete this data?",
        style: TextStyle(
          fontSize: 14,
          color: Colors.black
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            "yes",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black
            ),
          ),
          //konfirmasi dluu yaa sblm bener" di hapus
          //dengan cara memanggil dataCollection yg ada di firbase firstore
          onPressed: () {
            //untuk berkomunikasi dengan database untuk melakukan penghapusan data dri database
            datacollection.doc(documentId).delete(); // cara menghapus
            Navigator.pop(context);
          },
          ),
          TextButton(
            child: const Text(
              "No",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            )
      ],
    );
  }
}