import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<void> getLocationPosition(BuildContext context, Function(Position) onPositionReceived) async {
 // ignore: deprecated_member_use
 Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
 onPositionReceived(position);
}

//untuk mengambil lokasi saat ini
Future<void> getAddressFromLongLat(Position position, Function(String) onAddressReceived) async{
  List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark place = placemark[0];
  String address = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
  onAddressReceived(address);
}

Future<bool> handleLocationPermission(BuildContext context) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) { //user tidak memberi permission, jadi lokasi tidak diaktifkan
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Row(
        children: [
          Icon(Icons.location_off, color: Colors.white,
          ),
          SizedBox(width: 10),
          Text(
            "Location services are disabled. Please enable the services.",
            style: TextStyle(
              color: Colors.white
            ),
          )
        ],
      ),
      backgroundColor: Colors.blueGrey,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      )
    );
      return false; //untuk memblokir user
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) { //jika di cancel maka akan di back, dan harus di kill appnya
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) { //munculin snackbar lgi
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            children: [
              Icon(Icons.location_off,
              color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                "Location permission denied.",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          backgroundColor: Colors.blueGrey,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          )
      );
      return false; //untuk memblokir user
    }
  }

  if (permission == LocationPermission.deniedForever) { //jika ini di jalankan maka harus di install ulang, 
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.location_off,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Text("Location permission denied forever, we cannot acces.",
          style: TextStyle(color: Colors.white),
          )
        ],
      ),
      backgroundColor: Colors.blueGrey,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      ));
      return false; //untuk memblokir user
  }
  return true; //ini adalah salah satu positif, jika yang 3 negatif tdk di jalani maka return true akan jalan dan mengizinkan. dan langsung bisa proses absesnsi
} 
