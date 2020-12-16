import 'dart:async';

import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:micasa/provider/user_provider.dart';

class BluetoothProvider {
  final BeaconBroadcast _broadcast = BeaconBroadcast();

  Future<bool> initBeacon() async {
    bool isAdvertising = await _broadcast.isAdvertising();
    BeaconStatus transmissionSupportStatus = await _broadcast.checkTransmissionSupported();
    String uuid = await UserProvider().getUUID();

    if (!isAdvertising && transmissionSupportStatus == BeaconStatus.SUPPORTED) {
      final String iBeaconFormat = 'm:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24';
      await _broadcast
          .setUUID(uuid)
          .setMajorId(1)
          .setMinorId(100)
          .setIdentifier('com.beacon.sample')
          .setLayout(iBeaconFormat)
          .start();
    }
    return isAdvertising;
  }

  BeaconBroadcast broadcast() {
    return _broadcast;
  }
}
