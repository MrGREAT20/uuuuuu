import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../contracts/tokens.dart';
import '../utils/service_utils.dart';
import 'common/custom_iframe_widget.dart';
import 'common/dyte_mobile_widget.dart';

class DyteMeetingPage extends StatefulWidget {
  final String meetingId;
  final String participantId;
  final String participantName;
  final String? preset;
  final ServiceUtils serviceUtils;

  const DyteMeetingPage(
      {super.key,
      required this.meetingId,
      required this.participantId,
      required this.participantName,
      required this.serviceUtils,
      this.preset});

  @override
  State<DyteMeetingPage> createState() => _DyteMeetingPage();
}

class _DyteMeetingPage extends State<DyteMeetingPage> {
  late DyteTokens tokenData;

  @override
  void initState() {
    super.initState();
    _setAuthToken(widget.meetingId, widget.participantId,
        widget.participantName, widget.serviceUtils, widget.preset);
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const CustomIframeWidget();
    } else if (Platform.isAndroid || Platform.isIOS) {
      return DyteMobileWidget(authToken: tokenData.token);
    }
    return Container(
      color: Colors.amber,
      child: const Text("Unsupported System"),
    );
  }

  Future<void> _setAuthToken(String meetingId, String participantId,
      String participantName, ServiceUtils serviceUtils,String? preset) async {
    try {
      var result = await serviceUtils.getDyteMeetingTokens(participantId, meetingId, participantName, preset);
      setState(() {
        tokenData = result;
      });
    } catch (e) {
      //
    }
  }
}
