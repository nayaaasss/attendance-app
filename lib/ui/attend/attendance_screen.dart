import 'package:attendace_app/services/location_service.dart';
import 'package:attendace_app/services/timestamp_service.dart';
import 'package:attendace_app/ui/attend/components/app_bar.dart';
import 'package:attendace_app/ui/attend/components/capture_photo.dart';
import 'package:attendace_app/ui/attend/components/header.dart';
import 'package:attendace_app/ui/attend/components/location.dart';
import 'package:attendace_app/ui/attend/components/name_input.dart';
import 'package:attendace_app/ui/attend/components/submit_button.dart';
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
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(),
              buidlCapturePhotoSection(context, size, image),
              buildNamInputField(controllerName),
              buildLocationSection(isLoading, addressPlaceholder),
              buildSubmitButton(context, size, image, controllerName, addressPlaceholder, statusPlaceholder, timeStampPlaceholder),
            ],
          ),
        ),
      ),
    );
  }
}