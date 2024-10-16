import 'package:geolocator/geolocator.dart';

const url =
    '';
const LocationSettings locationSettings = LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 100,
);
