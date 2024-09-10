import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:html' as html; // For browser download functionality
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sih/API/send_images.dart';
import 'package:sih/API/send_images.dart';
import 'package:sih/Screens/page1.dart';
import 'package:sih/Screens/page2.dart';
import 'package:sih/Screens/passive_captcha.dart';

class M2 extends StatefulWidget {
  @override
  _M1State createState() => _M1State();
}

class _M1State extends State<M2> {
  DatabaseConnection db = new DatabaseConnection();

  List<List<double>> _mouseMovements = []; // Stores mouse movements
  bool _isTracking = false;
  Timer? _trackingTimer;
  String result = '';

  @override
  void initState() {
    super.initState();
    _startTracking(); // Start tracking when the widget is initialized
  }

  void _startTracking() {
    setState(() {
      _mouseMovements.clear(); // Clear previous movements
      _isTracking = true;
    });

    // Timer to stop tracking after 5 seconds
    _trackingTimer = Timer(Duration(seconds: 5), () {
      _stopTracking(); // Stop tracking after 5 seconds
    });
  }

  void _stopTracking() {
    setState(() {
      _isTracking = false;
    });
    if (_mouseMovements.isNotEmpty) {
      _generateImageFromMovements(); // Generate an image when tracking stops
    }
  }

  Future<String> getIPAddress() async {
    final response =
        await http.get(Uri.parse('https://api.ipify.org?format=json'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['ip'];
    } else {
      throw Exception('Failed to get IP address');
    }
  }

  Future<void> _generateImageFromMovements() async {
    final size = Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height); // Fullscreen size
    Uint8List imageBytes =
        await createImageFromMovements(_mouseMovements, size);

    String ipAddress = await getIPAddress();
    await db.sendData(ipAddress, imageBytes);
    await db.uploadCaptchaData();
    result = db.getResponse();
    //_downloadImage(imageBytes); // Automatically download the generated image
  }

  void _downloadImage(Uint8List imageBytes) {
    final blob = html.Blob([imageBytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute(
          "download", "mouse_path_${DateTime.now().millisecondsSinceEpoch}.png")
      ..click();
    html.Url.revokeObjectUrl(url); // Clean up the URL object after download
  }

  @override
  void dispose() {
    _trackingTimer?.cancel(); // Cancel the tracking timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegion(
        onHover: (event) {
          if (_isTracking) {
            setState(() {
              // Store the mouse movement coordinates
              _mouseMovements.add([
                double.parse(event.position.dx.toStringAsFixed(2)),
                double.parse(event.position.dy.toStringAsFixed(2))
              ]);
            });
          }
        },
        child: Container(
          color: Colors.transparent, // Ensure the container is transparent
          width: MediaQuery.of(context).size.width, // Fullscreen width
          height: MediaQuery.of(context).size.height,
          child: CaptchaScreen(), // Fullscreen height
        ),
      ),
    );
  }
}

// Function to create an image from the tracked mouse movements
Future<Uint8List> createImageFromMovements(
    List<List<double>> mouseMovements, Size size) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(
      recorder, Rect.fromPoints(Offset(0, 0), size.bottomRight(Offset.zero)));

  Paint backgroundPaint = Paint()
    ..color = Colors.white // Set the background color to white
    ..style = PaintingStyle.fill;

  Paint linePaint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke;

  // Draw the white background
  canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

  // Draw lines between tracked points
  if (mouseMovements.isNotEmpty) {
    for (int i = 0; i < mouseMovements.length - 1; i++) {
      Offset p1 = Offset(mouseMovements[i][0], mouseMovements[i][1]);
      Offset p2 = Offset(mouseMovements[i + 1][0], mouseMovements[i + 1][1]);
      canvas.drawLine(p1, p2, linePaint);
    }
  }

  final picture = recorder.endRecording();
  final img = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

  if (byteData != null) {
    return byteData.buffer.asUint8List();
  } else {
    throw Exception('Failed to create image bytes');
  }
}
