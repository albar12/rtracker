import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/exceptions.dart';
import 'package:rtracker/helper/preferences.dart';
import 'package:safe_device/safe_device.dart';

class Locations {
  static Future<LongLat?> lastPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw GeneralException(
        message: "Harap untuk menyalakan GPS anda.",
      );
    }

    LocationPermission locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied || locationPermission == LocationPermission.deniedForever) {
      locationPermission = await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.denied || locationPermission == LocationPermission.deniedForever) {
        throw GeneralException(
          message: "Harap untuk mengizinkan akses terhadap lokasi.",
        );
      }
    }

    bool isMock = false;

    if (Platform.isAndroid) {
      isMock = await SafeDevice.canMockLocation;

      if (isMock) {
        await Future.delayed(const Duration(seconds: 1));

        isMock = await SafeDevice.canMockLocation;
      }
    }

    if (isMock) {
      throw GeneralException(
        message: "Program mendeteksi adanya penggunaan fake GPS, silahkan untuk menonaktifkannya terlebih dahulu.",
      );
    }

    Position? position;

    try {
      position = await Geolocator.getCurrentPosition(
        timeLimit: const Duration(seconds: 5),
      );
    } catch (e) {
      position = await Geolocator.getLastKnownPosition();
    }

    if (position != null) {
      return LongLat(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } else {
      return LongLat(
        latitude: Preferences.getInstance().getDouble(SharedPreferenceKey.LAST_LATITUDE) ?? 0,
        longitude: Preferences.getInstance().getDouble(SharedPreferenceKey.LAST_LONGITUDE) ?? 0,
      );
    }
  }
}

class LongLat {
  final double latitude;
  final double longitude;

  LongLat({
    required this.latitude,
    required this.longitude,
  });
}
