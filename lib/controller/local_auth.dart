import 'package:local_auth/local_auth.dart';

import 'package:flutter/services.dart';

class LocalAuth {
  LocalAuthentication local_auth = LocalAuthentication();
  Future<bool> hasEnrolledBiometrics() async {
    final List<BiometricType> aviableBiometrics =
        await local_auth.getAvailableBiometrics();
    if (aviableBiometrics.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> authenticate() async {
    final bool didAuthenticate = await local_auth.authenticate(
        localizedReason: 'please authenticate to process',
        options: const AuthenticationOptions(biometricOnly: true));
    return didAuthenticate;
  }

  Future<List<BiometricType>> getBiometrics() async {
    try {
      return await local_auth.getAvailableBiometrics();
      // ignore: nullable_type_in_catch_clause
    } on PlatformException {
      return <BiometricType>[];
    }
  }
}
