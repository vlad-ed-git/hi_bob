import 'package:hi_bob/flavor_config.dart';
import 'package:hi_bob/main_common.dart';

void main() {
  FlavorConfig(
    appTitle: 'Hi Bob',
    apiEndpoint: '',
    packageName: 'com.hi_bob.hi_bob',
    isDevelopment: false,
  );
  mainCommon();
}
