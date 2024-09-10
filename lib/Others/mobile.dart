import 'dart:convert'; // For JSON encoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:intl/intl.dart'; // For formatting time

class ScrollTouchCoordinates extends StatefulWidget {
  @override
  _ScrollTouchCoordinatesState createState() => _ScrollTouchCoordinatesState();
}

class _ScrollTouchCoordinatesState extends State<ScrollTouchCoordinates> {
  ScrollController _scrollController = ScrollController();
  String scrollStartTime = "", scrollEndTime = ""; // To store scroll start and end times
  List<Map<String, dynamic>> scrollData = []; // Stores x, y coordinates and time data

  @override
  void initState() {
    super.initState();
  }

  // Rounds a value to two decimal places
  double _roundToTwoDecimalPlaces(double value) =>
      (value * 100).roundToDouble() / 100;

  // Send scroll data and times to the JSON server
  Future<void> _sendDataToJsonServer() async {
    var url = Uri.parse('http://192.168.1.94:3000/TouchMovements'); // Update with your server address
    var data = {
      'scrollData': scrollData,
      'scrollBegin': scrollStartTime,
      'scrollEnd': scrollEndTime,
    };

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      response.statusCode == 201
          ? print("Data sent successfully!")
          : print("Failed to send data: ${response.statusCode}");
    } catch (e) {
      print("Error sending data: $e");
    }
  }

  // Capture touch points and store them
  void _trackTouchPoints(Offset position) {
    double touchX = position.dx; // X-coordinate of the touch
    double touchY = position.dy; // Y-coordinate of the touch

    // Store touch points in scrollData
    setState(() {
      scrollData.add({
        'x': _roundToTwoDecimalPlaces(touchX),
        'y': _roundToTwoDecimalPlaces(touchY),
      });
      print('Touch added: (${_roundToTwoDecimalPlaces(touchX)}, ${_roundToTwoDecimalPlaces(touchY)})');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Touch and Scroll Tracker")),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollStartNotification) {
            scrollStartTime = DateFormat('hh:mm:ss').format(DateTime.now());
            scrollData = []; // Clear previous scroll data at the start of a new scroll
            print("Scroll started at: $scrollStartTime");
          }
          if (notification is ScrollEndNotification) {
            scrollEndTime = DateFormat('hh:mm:ss').format(DateTime.now());
            print("Scroll ended at: $scrollEndTime");
            _sendDataToJsonServer(); // Send data at the end of the scroll
          }
          return true;
        },
        child: GestureDetector(
          onPanUpdate: (details) {
            // Capture touch points during scrolling
            _trackTouchPoints(details.localPosition);
          },
          child: GridView.builder(
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              childAspectRatio: 1.0, // Aspect ratio to keep the grid cells square
            ),
            itemCount: 100,
            itemBuilder: (context, index) {
              return GridTile(
                child: Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Text('Item $index'),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}