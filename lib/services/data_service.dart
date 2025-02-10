import 'package:cloud_firestore/cloud_firestore.dart';


//get data dri internet
class DataService {
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance'); //inisialisasi firbase

  //untuk menampilkan history data, dengan cara mengambil data di firebase
  //dia nge get dri firbase
  Future<QuerySnapshot> getData() {
    return dataCollection.get(); //get data untuk memasukkan history, get itu (read)
  }

  //utuk menghapus
  Future<void> deleteData(String docId) {     
    return dataCollection.doc(docId).delete(); //jika dia melakukan delete maka firebase maka akan kehapus jga
  }
}