import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraControllerComponent {
  List<CameraDescription>? cameras; //? bergantung dg kesaiapn pd hardware tersebut
  CameraController? controller;
  bool isBusy = false;

  Future<void> loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) { //kondisi positif seolah-olah bekerja jika iya maka memanggil controller
      controller = CameraController(cameras![0], ResolutionPreset.high); //jika cameras![0] it means si 0 nya itu 1 itu adalah kamera depan, dan jika tdk memakai not maka dia akan menjadi kamera belakang.
      await controller!.initialize();                                    // dan kamera depan untuk face reconation, dan cara mmebuatnya itu hrs erlawanan karna minta kejelasan
                                                                        // resolutionPreset.high ini misalnya pasfoto, trs ke goyang itu hasilnya tetep HD
    }
  }
  Widget buildCameraPreview() {
    if (controller == null || !controller!.value.isInitialized) {
      // aksi apabila kondisi bernilai negatif
      return const Center(child: CircularProgressIndicator());
    }
    // aksi apabila kondisi bernilai positif
    return CameraPreview(controller!);
  }
}