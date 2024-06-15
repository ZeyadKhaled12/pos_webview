import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pos WebView',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse('https://pos.pspservicesco.com/login'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text('Pos System'),
        actions: [
          IconButton(
              onPressed: () async {
                if (await controller.canGoBack()) {
                  controller.goBack();
                }
              },
              icon: const Icon(Icons.arrow_back)),
          IconButton(
              onPressed: () async {
                if (await controller.canGoForward()) {
                  controller.goForward();
                }
              },
              icon: const Icon(Icons.arrow_forward)),
          IconButton(
              onPressed: () async {
                controller.reload();
              },
              icon: const Icon(Icons.replay_outlined))
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
