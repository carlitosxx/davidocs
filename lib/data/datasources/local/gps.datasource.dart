import 'dart:io';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:davidocs/core/errors/local_request.error.dart';
import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/domain/repositories/documents/documents.repository.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';

abstract class IGpsDataSource {
  ServiceAndPermissionOrFailure validateGps();
}

class GpsDataSourceImpl implements IGpsDataSource {
  @override
  ServiceAndPermissionOrFailure validateGps() async {
    LocationPermission permission;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Either.left(
        LocalRequestFailure.gpsNotEnabled(),
      );
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Either.left(
          LocalRequestFailure.gpsNotPermission(),
        );
      } else {
        final location = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        String network = '';
        for (var interface in await NetworkInterface.list()) {
          network += '== Interface: ${interface.name} ==';
          for (var addr in interface.addresses) {
            network +=
                "<${addr.address}|${addr.host}|${addr.isLoopback}|${addr.type.name}>";
          }
        }
        final String ipPublic;
        final androidDeviceInfo = await deviceInfo.androidInfo;
        final ipv4 = await Ipify.ipv4();
        ipPublic = ipv4;
        final String information =
            "App DaviDocs versión 2.0 con sistema operativo [ Android ${androidDeviceInfo.version.release} API Level ${androidDeviceInfo.version.sdkInt}] - IpPublica [$ipPublic] - RedLocal [$network] Mac: [unknown] Model: ${androidDeviceInfo.model}";
        Map<String, dynamic> response = {
          'information': information,
          'location': location,
        };
        return Either.right(response);
      }
    } else {
      final location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String network = '';
      for (var interface in await NetworkInterface.list()) {
        network += '== Interface: ${interface.name} ==';
        for (var addr in interface.addresses) {
          network +=
              "<${addr.address}|${addr.host}|${addr.isLoopback}|${addr.type.name}>";
        }
      }
      final String ipPublic;
      final androidDeviceInfo = await deviceInfo.androidInfo;
      final ipv4 = await Ipify.ipv4();
      ipPublic = ipv4;
      final String information =
          "App DaviDocs versión 2.0 con sistema operativo [ Android ${androidDeviceInfo.version.release} API Level ${androidDeviceInfo.version.sdkInt}] - IpPublica [$ipPublic] - RedLocal [$network] Mac: [unknown] Model: ${androidDeviceInfo.model}";
      Map<String, dynamic> response = {
        'information': information,
        'location': location,
      };
      return Either.right(response);
    }
    return Either.left(LocalRequestFailure.failureUnknown());
  }
}
