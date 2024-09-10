import 'package:flutter/material.dart';
import 'package:sih/API/send_images.dart';
import 'package:sih/MouseTracking/test2.dart';
import 'package:sih/Screens/page3.dart';
import 'package:sih/Screens/passive_captcha.dart';

// StatefulWidget for the main UI screen.
class AadhaarDownloadScreen extends StatefulWidget {
  final List<Map<String, String>> faqData = [
    {
      'question': 'What is e-Aadhaar?',
      'answer': 'e-Aadhaar is a digitally signed electronic version of Aadhaar.'
    },
    {
      'question': 'Is e-Aadhaar equally valid like physical copy of Aadhaar?',
      'answer':
          'Yes, e-Aadhaar is equally valid as the physical copy of Aadhaar.'
    },
    {
      'question': 'What is Masked Aadhaar?',
      'answer':
          'Masked Aadhaar is a version of your Aadhaar where the first 8 digits of your Aadhaar number are hidden.'
    },
    {
      'question': 'How to validate digital signatures in e-Aadhaar?',
      'answer':
          'You can validate digital signatures in e-Aadhaar using Adobe Reader.'
    },
    {
      'question': 'What is the Password of e-Aadhaar?',
      'answer':
          'The password to open e-Aadhaar is the first four letters of your name in capital letters followed by your year of birth.'
    },
    {
      'question': 'What supporting software is needed to open e-Aadhaar?',
      'answer': 'You need a PDF reader like Adobe Acrobat to open e-Aadhaar.'
    },
    {
      'question': 'How can an Aadhaar Number holder download e-Aadhaar?',
      'answer': 'You can download e-Aadhaar from the UIDAI website.'
    },
    {
      'question': 'From where can an Aadhaar number holder download e-Aadhaar?',
      'answer': 'e-Aadhaar can be downloaded from https://uidai.gov.in.'
    },
  ];

  @override
  _AadhaarDownloadScreenState createState() {
    return _AadhaarDownloadScreenState();
  }
}

// State class for AadhaarDownloadScreen
class _AadhaarDownloadScreenState extends State<AadhaarDownloadScreen> {
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController captchaController = TextEditingController();
  DatabaseConnection db = DatabaseConnection();
  String result = '';
  // Selected option for radio buttons
  String selectedOption = "Aadhaar Number";
  final List<String> options = [
    "Aadhaar Number",
    "Enrolment ID Number",
    "Virtual ID Number"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'Assets/ashok-pillar-symbol.jpg',
                  width: 80,
                  height: 50,
                ),
                SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unique Identification Authority of India',
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    Text(
                      'Government of India',
                      style: TextStyle(
                          fontSize: 12, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ],
                ),
              ],
            ),
            Image.asset(
              'Assets/images.png',
              width: 80,
              height: 50,
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          const Expanded(
              flex: 1,
              child: SizedBox(
                width: 10,
              )),
          // Form Section
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey, // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(12), // Add rounded corners
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Add padding to content
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select 12 digit Aadhaar Number / 16 digit Virtual ID (VID) Number / 28 digit Enrollment ID (EID) Number',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),

                      // Radio buttons for selection
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: options.map((option) {
                          return RadioListTile(
                            title: Text(option),
                            value: option,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value.toString();
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),

                      // Aadhaar/VID/EID Input
                      TextField(
                        controller: aadhaarController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Enter $selectedOption',
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Submit Button
                      Center(
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              // Get the result first, without updating the state
                              String fetchedResult = await db.getResponse();

                              // Now, update the state synchronously
                              setState(() {
                                result = fetchedResult;
                              });

                              print("1 $result");

                              // Perform navigation based on the result
                              if (result == 'Bot') {
                                print("2 $result");
                                // If bot, navigate to the CaptchaScreen
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => M2()),
                                );
                              } else {
                                print("3 $result");
                                // If human, navigate to PDFDownloadScreen
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PDFDownloadScreen()),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              elevation: 5,
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // FAQ Section
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: widget.faqData.length,
              itemBuilder: (context, index) {
                var faq = widget.faqData[index];
                return ExpansionTile(
                  title: Text(faq['question']!),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(faq['answer']!),
                    ),
                  ],
                );
              },
            ),
          ),
          const Expanded(
              flex: 1,
              child: SizedBox(
                width: 10,
              )),
        ],
      ),
    );
  }
}
