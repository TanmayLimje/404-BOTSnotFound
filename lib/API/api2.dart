import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'dart:html';
import 'package:http_parser/http_parser.dart'; // For setting the content type

class DatabaseConnection {
  late String ipAddress;
  late Uint8List image;
  String sessionId = '';
  bool isDone = false;

  Future<void> sendData(String ipAddress, Uint8List image) async {
    this.ipAddress = ipAddress;
    this.image = image;
  }

  Future<void> uploadCaptchaData() async {
    // Define your API URL
    final url = Uri.parse('http://localhost:8080/api/captcha/upload');

    // Prepare your multipart request
    var request = http.MultipartRequest('POST', url);

    // Add form data
    request.fields['ip_address'] = ipAddress;
    request.fields['session_id'] = sessionId;
    request.fields['done'] = '$isDone';

    request.headers['User-Agent'] =
        'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Mobile Safari/537.36';
    request.headers['Accept'] = '*/*';

    // Add the image as MultipartFile from the Uint8List
    request.files.add(http.MultipartFile.fromBytes(
      'images', // Field name for the API
      image,
      filename: 'captcha_image.png', // Name the file as needed
      contentType: MediaType('image', 'png'), // Set the content type
    ));
    print('00');
    // Send the request
    try {
      print('Sending to URL: $url');
      print('Fields: ${request.fields}');
      print('Headers: ${request.headers}');

      var response = await request.send().timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var jsonResponse = jsonDecode(responseData.body);
        print('Success: Response: $jsonResponse');
      } else {
        print('Error: Response code ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred while uploading: $e');
    }
  }
}
