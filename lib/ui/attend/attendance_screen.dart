import 'package:attendace_app/services/location_service.dart';
import 'package:attendace_app/services/timestamp_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  final XFile? image;

  const AttendanceScreen({super.key, this.image});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState(this.image);
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  _AttendanceScreenState(this.image);

  XFile? image;
  String addressPlaceholder = '', datePlaceholder = '', timePlaceholder = '',timeStampPlaceholder = '', statusPlaceholder = 'Attend';
  bool isLoading = false;
  final controllerName = TextEditingController();

  @override
  void initState() { 
    super.initState();
    handleLocationPermission(context);
    setDateTime((date, time, timeStamp) { // persiapan mengambil datanya setelah dia di compile
      setState(() {
        datePlaceholder = date;
        timePlaceholder = time;
        timeStampPlaceholder = timeStamp;
      });
    });
    setAttendanceStatus((status) {
      setState(() {
        statusPlaceholder = status;
      });
    });
    if (image != null) { // jika ada gambar sudah di upload
      isLoading = true;
    getGeoLocationPosition(context, (position) {
        setState(() {
          isLoading = false;
          getAddressFromLongLat(position, (address) {
            setState(() {
              addressPlaceholder = address;
            });
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
      ),
    );
  }
}