import 'package:attendace_app/ui/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( //harus diinialisasi terlebih dlu sebelum menggunakan layanan firbase yg lain
    options: const FirebaseOptions(
      //data di ambil dari file google-services.json
      apiKey: 'AIzaSyCxYiv5yRB3CGCjzss-zyHoG11VveyvSy4', // current_key
      appId: '1:42097042731:android:6a6dbc7a5251181d6d916e', //mobilesdk_app_id
      messagingSenderId: '42097042731',  //project_number
      projectId: 'attendance-app-57562' //project_id
      )
  ); 
  runApp(const AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        cardTheme: const CardTheme(surfaceTintColor: Colors.white,),
        dialogTheme: const DialogTheme(surfaceTintColor: Colors.white, backgroundColor: Colors.white),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true
      ),
      home: const HomeScreen(),
    );
  }
}