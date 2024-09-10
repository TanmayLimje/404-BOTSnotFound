import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting time
import 'package:http/http.dart' as http; // Add this

class CaptchaDemo extends StatefulWidget {
  @override
  _CaptchaDemoState createState() => _CaptchaDemoState();
}

class _CaptchaDemoState extends State<CaptchaDemo> {
  Offset _mousePosition = Offset.zero;
  List<List<double>> _mouseMovements = [];
  Timer? _timer;
  bool _isRecording = true; // To control recording state
  String _startTime = '';

  @override
  void initState() {
    super.initState();
    _startRecording();
  }

  void _startRecording() {
    _startTime = DateFormat('hh:mm:ss').format(DateTime.now()); // Record start time
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_isRecording) {
        _logMouseMovements();
        setState(() {
          _isRecording = false; // Pause recording after 2 seconds
        });
        _startPauseTimer(); // Start pause timer
      }
    });
  }

  void _startPauseTimer() {
    Timer(Duration(seconds: 5), () {
      if (!_isRecording) {
        setState(() {
          _isRecording = true; // Resume recording after 5 seconds
        });
        _startRecording(); // Restart recording
      }
    });
  }

  Future<void> _logMouseMovements() async {
    List<dynamic> movementsWithTime = [
      {'start_time': _startTime, 'movements': _mouseMovements}
    ];

    // Print the 2D array with start time
    print(jsonEncode(movementsWithTime));

    // Send the data to the JSON server
    await _sendDataToServer(movementsWithTime);

    _mouseMovements.clear(); // Clear movements after logging
  }

  Future<void> _sendDataToServer(List<dynamic> data) async {
    const url = 'http://192.168.1.94:3000/MouseMovements'; // Replace with your server URL
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        print('Data saved successfully');
      } else {
        print('Failed to save data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error saving data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Listener(
            onPointerHover: (event) {
              if (_isRecording) {
                setState(() {
                  _mousePosition = event.position;
                  _mouseMovements.add([
                    double.parse(_mousePosition.dx.toStringAsFixed(2)),
                    double.parse(_mousePosition.dy.toStringAsFixed(2))
                  ]);
                });
              }
            },
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              color: Colors.lightBlueAccent,
              child: CustomPaint(
                painter: MouseMovementPainter(_mouseMovements),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Mouse Position: ${_mousePosition.dx.toStringAsFixed(2)}, ${_mousePosition.dy.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Tracking movements for CAPTCHA...',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
    print('Final Mouse Movements: $_mouseMovements');
  }
}

class MouseMovementPainter extends CustomPainter {
  final List<List<double>> mouseMovements;

  MouseMovementPainter(this.mouseMovements);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    if (mouseMovements.isNotEmpty) {
      for (int i = 0; i < mouseMovements.length - 1; i++) {
        // Drawing lines between the points using rounded coordinates
        Offset p1 = Offset(mouseMovements[i][0], mouseMovements[i][1]);
        Offset p2 = Offset(mouseMovements[i + 1][0], mouseMovements[i + 1][1]);
        canvas.drawLine(p1, p2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
