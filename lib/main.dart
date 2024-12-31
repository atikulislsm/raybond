import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late WebViewControllerPlus controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=WebViewControllerPlus(
    )..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(NavigationDelegate(
          onProgress: (int progress){
            setState(() {
            });
          },
          onPageStarted: (String url) {
          },
          onPageFinished: (String url) {
          },
          onHttpError: (HttpResponseError error) {
          },
          onWebResourceError: (WebResourceError error) {
            print("Error: ${error.description}");
          },
          onNavigationRequest: (NavigationRequest request){
            if(request.url.startsWith('https://www.youtube.com')){
              return NavigationDecision.prevent;
            }
            else if( request.url.startsWith('tel:')){
              _launchUrl(request.url);
              return NavigationDecision.prevent;
            }
            else if (request.url.startsWith('mailto:')) {
              _launchUrl(request.url);
              return NavigationDecision.prevent;
            }
            else if (request.url.startsWith('https://wa.me/') || request.url.startsWith('whatsapp://')) {
              _launchUrl(request.url);
              return NavigationDecision.prevent;
            }
            else if(request.url.startsWith('https://play.google.com/')){
              _launchUrl(request.url);
              return NavigationDecision.prevent;
            }
            else if(request.url.startsWith('https://www.facebook.com/')){
              _launchUrl(request.url);
              return NavigationDecision.prevent;
            }
            else if(request.url.startsWith('https://x.com/')){
              _launchUrl(request.url);
              return NavigationDecision.prevent;
            }
            else if(request.url.startsWith('https://www.linkedin.com/')){
              _launchUrl(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          }
      ))..loadRequest(Uri.parse('https://raybond.com.bd/'));

  }
  Future<bool> _onWillPop() async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return Future.value(false); // Prevent app from closing
    }
    return Future.value(true); // Allow the app to close if no back history
  }
  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,mode: LaunchMode.externalApplication );
    } else {
      throw 'Could not launch $url';
    }
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: WillPopScope(child: Scaffold(
        body: WebViewWidget(controller: controller,),

      ), onWillPop: _onWillPop)),
    );
  }
}
