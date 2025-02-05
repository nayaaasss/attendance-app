import 'dart:math';
import 'package:attendace_app/utils/google_ml_kit.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectorComponent {
  final FaceDetector faceDetector = GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
    enableTracking: true,
    enableLandmarks: true,
  ));

  Future<void> detectFaces(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path); //untuk menginput dri kamera, mengenerate dri camera ke path
    final faces = await faceDetector.processImage(inputImage); 

    for (Face face in faces) { // mau mmebuat looping, mksdnya klo misalkan face sudh terdeteksi
    //Rect ini adalah rectengle 2d agar tdk bsa ditip org lain
      final Rect boundingBox = face.boundingBox; //untuk mendapatkan bounding boxnya, dia akan mengambil komponen(positioning) dri wajah, jd image yg kita ambil itu punya titik kodinat (0, 0)

      //untuk menghendle posisi wajah secara vertical
      final double? verticalPosition = face.headEulerAngleY; 
      //untuk menghandle posisi wajah secara horizontal, sumbu z pengganti sumbu x, ml tuh punya rumusnya sndiri.
      final double? horizontalPosition = face.headEulerAngleZ;
      //perkondisian apabila face landmark(organ wajah) sudah aktif, ditandai oleh (mulut, mata, pipi dan hidung dan telinga)
      final FaceLandmark? leftEar = face.landmarks[FaceLandmarkType.leftEar]; //nullable mksdnya bisa ada kuping bisa ga
      //jika left ear terdetekri
      if (leftEar != null) {
        final Point<int> leftEarPosition = leftEar.position; //jika kupingnya terdeteksi maka dia akan return si posisi telinga tersebut yg di kembalikn adalah titik kordinat.
        print("Left Ear Position: $leftEarPosition"); //posisinya akan di cetak untuk melakukan verifikasi
      }

      //perkondisian apabila wajahnya terdeteksi (di tandai dengan bibir tersenyum)
      if (face.smilingProbability != null) {
        final double? smileProbability = face.smilingProbability;
        print("smile Probability: $smileProbability"); 
      }

      //perkondisian apabila fitur tracking wajah sudah aktif
      if (face.trackingId != null) {
        final int? trackingId = face.trackingId;
        print("Tracking ID: $trackingId");
      }
    } 

  }
}