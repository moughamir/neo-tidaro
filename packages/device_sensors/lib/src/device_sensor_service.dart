import 'package:sensors_plus/sensors_plus.dart';

/// Simple device sensor service exposing gyroscope stream.
class DeviceSensorService {
  /// Stream of gyroscope events.
  Stream<GyroscopeEvent> get gyroscopeEvents => gyroscopeEventStream();
}
