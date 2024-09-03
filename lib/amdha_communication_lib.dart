library amdha_communication_lib;

import 'package:amdha_communication_lib/src/utils/service_utils.dart';

class AmdhaCommunincationUtils {
  static final AmdhaCommunincationUtils _instance =
      AmdhaCommunincationUtils._privateContructor();

  static AmdhaCommunincationUtils _privateContructor() {
    return AmdhaCommunincationUtils();
  }

  static AmdhaCommunincationUtils get instance =>
      AmdhaCommunincationUtils._instance;

  static void initiate() {}

  ServiceUtils serviceUtils = ServiceUtils(basePath: "", bearerToken: "");
}
