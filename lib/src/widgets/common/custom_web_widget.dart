import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebViewWidget extends StatefulWidget {
  const CustomWebViewWidget({
    super.key,
    this.width,
    this.height,
    required this.uri,
    required this.onRecievedMessage,
  });

  final double? width;
  final double? height;
  final String uri;
  final Future Function(String? message) onRecievedMessage;

  @override
  State<CustomWebViewWidget> createState() => _CustomWebViewWidgetState();
}

class _CustomWebViewWidgetState extends State<CustomWebViewWidget> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          
        },
        onProgress: (progress) {},
        onPageFinished: (url) {},
      ))
      ..loadRequest(
        Uri.parse(widget.uri),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'AMDHA_COMMUNICATION',
        onMessageReceived: (message) {
          widget.onRecievedMessage(message.message);
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 300,
        child: WebViewWidget(
          controller: controller,
        ));
  }
}

