import 'package:amdha_communication_lib/amdha_communication_lib.dart';
import 'package:amdha_communication_lib/src/enums/communication_plat_form.dart';
import 'package:amdha_communication_lib/src/utils/service_utils.dart';
import 'package:amdha_communication_lib/src/widgets/azure_meeting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dyte_meeting_page.dart';

class AmdhaCommunincationWidget extends StatefulWidget {
  final ServiceUtils serviceUtils;
  final CommunicationPlatform communincationPlatform;
  final AmdhaCommunincationUtils amdhaCommunincationUtils;
  const AmdhaCommunincationWidget(
      {super.key,
      required this.serviceUtils,
      required this.communincationPlatform, 
      required this.amdhaCommunincationUtils});

  @override
  State<StatefulWidget> createState() => _AmdhaCommunincationWidget();
}

class _AmdhaCommunincationWidget extends State<AmdhaCommunincationWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.communincationPlatform == CommunicationPlatform.dyte) {
      return DyteMeetingPage(
          meetingId: "",
          participantId: "",
          participantName: "",
          serviceUtils: widget.amdhaCommunincationUtils.serviceUtils,
          preset: "");
    } else if (widget.communincationPlatform == CommunicationPlatform.azure) {
      return const AzureMeetingPage();
    } else {
      return Container(
          color: Colors.amber,
          child: const Text("Unsupported Communication Platform"));
    }
  }
}
