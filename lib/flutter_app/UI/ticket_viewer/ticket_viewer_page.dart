import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:turbovets_messaging_app/flutter_app/constants/app_colors.dart';

class TicketViewerPage extends StatefulWidget {
  const TicketViewerPage({super.key});

  @override
  State<TicketViewerPage> createState() => _TicketViewerPageState();
}

class _TicketViewerPageState extends State<TicketViewerPage> {
  WebViewController? _controller;
  bool _isLoading = true;
  bool _isSupported = false;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    // WebView is only supported on mobile platforms (iOS and Android)
    if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      _isSupported = true;
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
        )
        ..loadRequest(Uri.parse('http://localhost:4200/ticket-viewer'));
    } else {
      _isSupported = false;
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ticket Viewer',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _isSupported && _controller != null
          ? Stack(
              children: [
                WebViewWidget(controller: _controller!),
                if (_isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: AppColors.buttonColor,
                    ),
                  ),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.web_asset_off,
                    size: 64,
                    color: AppColors.greyColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'WebView is not supported on this platform',
                    style: TextStyle(color: AppColors.greyColor, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please run on iOS or Android',
                    style: TextStyle(color: AppColors.greyColor, fontSize: 14),
                  ),
                ],
              ),
            ),
    );
  }
}
