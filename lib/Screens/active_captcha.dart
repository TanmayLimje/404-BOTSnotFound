import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sih/Screens/page3.dart';

class ImageCaptchaScreen extends StatefulWidget {
  @override
  _ImageCaptchaScreenState createState() => _ImageCaptchaScreenState();
}

class _ImageCaptchaScreenState extends State<ImageCaptchaScreen> {
  List<String> captchaImages = [
    'Assets/Screenshot 2024-09-09 183531.png',
    'Assets/Screenshot 2024-09-09 183712.png',
    'Assets/Screenshot 2024-09-09 184039.png',
    'Assets/Screenshot 2024-09-09 185022.png'
  ];

  List<String> captchaAnswers = [
    'BMVHKY',  // Correct answer for captcha1.png
    '3nc9z',  // Correct answer for captcha2.png
    '2pvcb',
    'quxg4h'   // Correct answer for captcha3.png
  ];

  int currentCaptchaIndex = 0;
  TextEditingController userInputController = TextEditingController();
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    generateCaptcha();
  }

  void generateCaptcha() {
    // Randomly select a CAPTCHA image
    setState(() {
      currentCaptchaIndex = Random().nextInt(captchaImages.length);
      errorMessage = "";
      userInputController.clear();
    });
  }

  void verifyCaptcha() {
    if (userInputController.text == captchaAnswers[currentCaptchaIndex]) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PDFDownloadScreen()),
        );
    } else {
      setState(() {
        errorMessage = "CAPTCHA Incorrect, try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,  // Set the background color to black
      appBar: AppBar(
        title: Text("Image-based CAPTCHA"),
        backgroundColor: Colors.black,  // AppBar background to match the theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display CAPTCHA image
            Image.asset(
              captchaImages[currentCaptchaIndex],
              height: 100,
              width: 300,
            ),
            SizedBox(height: 20),
            // Input for user to type the CAPTCHA, wrapped in Padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),  // Padding added
              child: TextField(
                controller: userInputController,
                style: TextStyle(color: Colors.white),  // Text color set to white
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[800],  // Text field background color
                  border: OutlineInputBorder(),
                  labelText: 'Enter CAPTCHA text',
                  labelStyle: TextStyle(color: Colors.white),  // Label text color
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: verifyCaptcha,
              
              child: Text("Submit"),
            ),
            SizedBox(height: 20),
            // Error or Success Message
            Text(
              errorMessage,
              style: TextStyle(
                fontSize: 18,
                color: errorMessage == "CAPTCHA Verified!" ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 20),
            // Button to regenerate CAPTCHA
            TextButton(
              onPressed: generateCaptcha,
              child: 
              Text(
                "Regenerate CAPTCHA",
                style: TextStyle(color: Colors.white, ),  // Regenerate button text color
              ),
              style: ButtonStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
