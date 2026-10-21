import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

final InAppLocalhostServer localServer = InAppLocalhostServer(
  documentRoot: 'assets/www',
  port: 8080,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await localServer.start();
  runApp(const WizardChessApp());
}

class WizardChessApp extends StatelessWidget {
  const WizardChessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest:
              URLRequest(url: WebUri('http://localhost:8080/index.html')),
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            mediaPlaybackRequiresUserGesture: false,
            allowsInlineMediaPlayback: true,
            hardwareAcceleration: true,
            supportZoom: false,
            disableContextMenu: true,
            transparentBackground: false,
          ),
          onConsoleMessage: (controller, msg) =>
              debugPrint('[JS] ${msg.message}'),
        ),
      ),
    );
  }
}
