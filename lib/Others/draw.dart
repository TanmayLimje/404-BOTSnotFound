import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // For RepaintBoundary
import 'package:path_provider/path_provider.dart'; // For storing the image (mobile platforms)
import 'dart:ui'; // For converting image to byte data
import 'package:flutter/foundation.dart' show kIsWeb; // For checking platform type
import 'dart:html' as html; // For web-specific file handling

class MouseTrackingScreen extends StatefulWidget {
  @override
  _MouseTrackingScreenState createState() => _MouseTrackingScreenState();
}

class _MouseTrackingScreenState extends State<MouseTrackingScreen> {
  List<Offset> _points = []; // Stores the mouse positions
  bool _tracking = true; // Whether tracking is active or not
  Timer? _timer; // Timer for 10 seconds
  GlobalKey _globalKey = GlobalKey(); // Key to capture the RepaintBoundary

  @override
  void initState() {
    super.initState();
    // Start a 10-second timer
    _timer = Timer(Duration(seconds: 10), () async {
      setState(() {
        _tracking = false; // Stop tracking after 10 seconds
      });
      await _saveImage(); // Save the image after tracking stops
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Clean up the timer when the widget is disposed
    super.dispose();
  }

  Future<void> _saveImage() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      if (kIsWeb) {
        // Web-specific logic to handle downloading the file in the browser
        final blob = html.Blob([pngBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute("download", "mouse_movement.png")
          ..click();
        html.Url.revokeObjectUrl(url);
        print("Image downloaded");
      } else {
        // For mobile and desktop
        String filePath;
        if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
          // Custom directory path for desktop platforms
          String customDirectory = '/path/to/your/directory';
          filePath = '$customDirectory/mouse_movement.png';
        } else {
          // Using path_provider for mobile platforms
          final directory = await getApplicationDocumentsDirectory();
          filePath = '${directory.path}/mouse_movement.png';
        }

        final imgFile = File(filePath);
        await imgFile.writeAsBytes(pngBytes);
        print("Image saved at: $filePath");
      }
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Visible Container with Blue Background and Text
        Container(
          color: Colors.blue,
          child: Center(
            child: Text(
              'Track the Mouse',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
        // Invisible MouseTrackingOverlay
        Positioned.fill(
          child: MouseRegion(
            onHover: (event) {
              if (_tracking) {
                setState(() {
                  _points.add(event.localPosition); // Add mouse position if tracking
                });
              }
            },
            child: Container(
              color: Colors.transparent, // Ensure the tracking layer is invisible
              child: RepaintBoundary(
                key: _globalKey, // Assign the key to RepaintBoundary
                child: CustomPaint(
                  painter: MouseDrawingPainter(_points),
                  size: Size.infinite, // Ensure the size covers the entire area
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MouseDrawingPainter extends CustomPainter {
  final List<Offset> points;

  MouseDrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Paint linePaint = Paint()
      ..color = Colors.red  // Change line color to red
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    // Draw the white background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Draw the lines between consecutive points
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint to show new lines
  }
}
