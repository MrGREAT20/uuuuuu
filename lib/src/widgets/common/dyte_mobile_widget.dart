import 'package:dyte_uikit/dyte_uikit.dart';
import 'package:flutter/widgets.dart';

import '../../notifiers/dyte_nofitier.dart';

class DyteMobileWidget extends StatefulWidget {
  final String authToken;
  const DyteMobileWidget({super.key, required this.authToken});

  @override
  State<DyteMobileWidget> createState() => _DyteMobileWidget();
}

class _DyteMobileWidget extends State<DyteMobileWidget> {
  late DyteUIKitInfo _uiKitInfo;

  @override
  void initState() {
    super.initState();
    _uiKitInfo = DyteUIKitInfo(DyteMeetingInfoV2(authToken: widget.authToken));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DyteUIKitBuilder.build(uiKitInfo: _uiKitInfo),
    );
  }
}
