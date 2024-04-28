import 'package:flutter/material.dart';
import 'package:shoppe_customer/view/screens/loading/loading_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
//import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class PrivacyAndPolicy extends StatefulWidget {
  const PrivacyAndPolicy({super.key});

  @override
  State<PrivacyAndPolicy> createState() => _PrivacyAndPolicyState();
}

class _PrivacyAndPolicyState extends State<PrivacyAndPolicy> {
  bool isLoading = false;
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
            setState(() {
              position = 1;
            });
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            setState(() {
              position = 0;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   debugPrint('blocking navigation to ${request.url}');
            //   return NavigationDecision.prevent;
            // }
            // debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..runJavaScript(
          "document.getElementsByClassName('kopa-breadcrumb')[0].style.display='none';"
          "document.getElementsByClassName('page-header')[0].style.display='none';"
          "document.getElementById('kopa-page-header').style.display='none'"
          "document.getElementById('bottom-sidebar').style.display='none'"
          "document.getElementById('back-top').style.display='none'"
          "document.getElementById('floatBtn-1').style.display='none'"
          "document.getElementsByTagName('header').style.display='none'"
          "document.getElementsByTagName('footer').style.display='none'"
          "document.getElementsByClassName('kopa-breadcrumb')[0].style.display='none'")
      ..loadRequest(Uri.parse('https://carclenx.com/privacy-policy'));
//
//     // #docregion platform_features
//     if (controller.platform is AndroidWebViewController) {
//       AndroidWebViewController.enableDebugging(true);
//       (controller.platform as AndroidWebViewController)
//           .setMediaPlaybackRequiresUserGesture(false);
//     }
//     // #enddocregion platform_features
//
//     _controller = controller;
  }

  // final Completer<WebViewController> _completController =
  //     Completer<WebViewController>();

  // WebViewController _myController;

  int position = 1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.75;
    return SizedBox(
      height: height,
      child: IndexedStack(
        index: position,
        children: [

          WebViewWidget(controller: _controller!),
          // WebView(
          //   initialUrl: 'https://carclenx.com/privacy-policy',
          //   javascriptMode: JavascriptMode.unrestricted,
          //   gestureNavigationEnabled: true,
          //   zoomEnabled: false,
          //   onWebViewCreated: (WebViewController webViewController) async {
          //     _completController.future.then((value) => _myController = value);
          //     _completController.complete(webViewController);
          //   },
          //   onPageStarted: (url) {
          //     print("Navigated to : " + url);
          //     setState(() {
          //       position = 1;
          //     });
          //   },
          //   onPageFinished: (url) async {
          //     print("page completed");
          //     setState(() {
          //       position = 0;
          //     });
          //     _myController.runJavascript(
          //         "document.getElementsByClassName('kopa-breadcrumb')[0].style.display='none';");
          //     _myController.runJavascript(
          //         "document.getElementsByClassName('page-header')[0].style.display='none';");
          //     _myController.runJavascript(
          //         "document.getElementById('kopa-page-header').style.display='none'");
          //     _myController.runJavascript(
          //         "document.getElementById('bottom-sidebar').style.display='none'");
          //     _myController.runJavascript(
          //         "document.getElementById('back-top').style.display='none'");
          //     _myController.runJavascript(
          //         "document.getElementById('floatBtn-1').style.display='none'");
          //     _myController.runJavascript(
          //         "document.getElementsByTagName('header').style.display='none'");
          //     _myController.runJavascript(
          //         "document.getElementsByTagName('footer').style.display='none'");
          //     _myController.runJavascript(
          //         "document.getElementsByClassName('kopa-breadcrumb')[0].style.display='none'");

          //     var html = await _myController.runJavascriptReturningResult(
          //         "window.document.getElementById('upside-page-content')[0];");

          //     print(html);
          //   },
          //   onProgress: (progress) {
          //     print('WebView is loading (progress : $progress%)');

          //     // if (progress == 100) {
          //     //   isLoading = false;
          //     //   setState(() {});
          //     // } else {
          //     //   isLoading = true;
          //     //   setState(() {});
          //     // }
          //   },
          //   navigationDelegate: (NavigationRequest request) {
          //     // if (request.url.endsWith(".com/")) {
          //     //   if (kDebugMode) {
          //     //     print('blocking navigation to $request}');
          //     //   }
          //     //   return NavigationDecision.prevent;
          //     // }
          //     if (kDebugMode) {
          //       print('allowing navigation to $request');
          //     }
          //     return NavigationDecision.navigate;
          //   },
          // ),

          const LoadingScreen(),
        ],
      ),
    );
  }
}
