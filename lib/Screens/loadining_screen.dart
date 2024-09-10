import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sih/API/send_images.dart';
import 'package:sih/Screens/active_captcha.dart';
import 'package:sih/Screens/page2.dart';
import 'package:sih/Screens/page3.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  DatabaseConnection db = DatabaseConnection();
  String result = '';

  @override
  void initState() {
    super.initState();

    // Set a delay for navigation to the next screen
    Future.delayed(Duration(seconds: 5), () async {
      String fetchedResult = await db.getResponse();

      // Now, update the state synchronously
      setState(() {
        result = fetchedResult;
      });

      // Perform navigation based on the result
      if (result == 'Bot') {
        // If bot, navigate to the CaptchaScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ImageCaptchaScreen()),
        );
      } else {
        // If human, navigate to PDFDownloadScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PDFDownloadScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitWave(
            color: Colors.white,
            size: 50.0,
          ),
          SizedBox(height: 20),
          Text(
            "Wait a moment",
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
