import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:uuid/uuid.dart';

Future<bool> initBluetooth() async {
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();
  bool isAdvertising = await beaconBroadcast.isAdvertising();
  BeaconStatus transmissionSupportStatus = await beaconBroadcast.checkTransmissionSupported();

  if (!isAdvertising && transmissionSupportStatus == BeaconStatus.SUPPORTED) {
    final String iBeaconFormat = 'm:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24';
    await beaconBroadcast
        .setUUID(Uuid().v4())
        .setMajorId(1)
        .setMinorId(100)
        .setIdentifier('com.beacon.sample')
        .setLayout(iBeaconFormat)
        .start();
  }
  return isAdvertising;
}
