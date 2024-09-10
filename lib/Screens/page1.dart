import 'package:flutter/material.dart';
import 'package:sih/MouseTracking/test.dart';
import 'package:sih/MouseTracking/test2.dart';
import 'package:sih/Others/mouse_trackin.dart';
import 'package:sih/Screens/page2.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  
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
      body: Column(
        children: [
          // Container for the dropdown menus and search bar
          Container(
            color: Colors.blue[800],
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDropdownButton(
                    'My Aadhaar', ['My Aadhaar', 'Update', 'Download']),
                _buildDropdownButton(
                    'About UIDAI', ['About UIDAI', 'Overview', 'Leadership']),
                _buildDropdownButton(
                    'Ecosystem', ['Ecosystem', 'Services', 'Partners']),
                _buildDropdownButton('Media & Resources',
                    ['Media & Resources', 'News', 'Events']),
                _buildDropdownButton('Contact & Support',
                    ['Contact & Support', 'Help', 'Centers']),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.blue[700],
                      filled: true,
                      suffixIcon: Icon(Icons.search, color: Colors.white),
                      contentPadding: EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side: Aadhaar cards
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildAadhaarCard(
                                title: 'Book an Appointment',
                                description:
                                    'For Enrolment or to update your Aadhaar data, you can book an online appointment at an Aadhaar Seva Kendra.',
                                actionText: 'Book an Appointment',
                              ),
                              _buildAadhaarCard(
                                title: 'Check status',
                                description:
                                    'Recently enrolled for Aadhaar? Check if your Aadhaar is generated. You can also check the Update Address here too.',
                                actionText: 'Check Aadhaar Status',
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            M1()),
                                  );
                                },
                                child: _buildAadhaarCard(
                                  title: 'Download Aadhaar',
                                  description:
                                      'Download an electronic version of your Aadhaar by giving your Aadhaar number or Enrolment ID. Downloaded Aadhaar is as valid as the original Aadhaar letter.',
                                  actionText: 'Download Aadhaar',
                                ),
                              ),
                              _buildAadhaarCard(
                                title: 'Update Aadhaar',
                                description:
                                    'Update your Aadhaar details like your address or mobile number by visiting an authorized update center or doing it online.',
                                actionText: 'Update Aadhaar',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        // Right side: FAQ Section
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFAQ(
                                title: 'What is e-Aadhaar?',
                                content:
                                    'e-Aadhaar is a password protected electronic copy of Aadhaar, which is digitally signed by the competent Authority of UIDAI.',
                              ),
                              _buildFAQ(
                                title: 'How to find Aadhaar Centers?',
                                content:
                                    'You can find your nearest Aadhaar centers by visiting the UIDAI website and searching by your location.',
                              ),
                              _buildFAQ(
                                title: 'What is the mAadhaar app?',
                                content:
                                    'mAadhaar is an official mobile application that allows you to carry your Aadhaar information on your smartphone.',
                              ),
                              _buildFAQ(
                                title: 'How to update Aadhaar details?',
                                content:
                                    'You can update your Aadhaar details by visiting the nearest update center or using the online self-service portal.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: const Color.fromARGB(255, 66, 159, 230),
                      padding: EdgeInsets.all(16),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Contact Us',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          SizedBox(height: 8),
                                          Text('Toll-free: 1947'),
                                          Text('Email: help@uidai.gov.in'),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Follow Us',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text('Facebook'),
                                              SizedBox(width: 10),
                                              Text('Twitter'),
                                              SizedBox(width: 10),
                                              Text('Youtube'),
                                              SizedBox(width: 10),
                                              Text('Instagram'),
                                              SizedBox(width: 10),
                                              Text('LinkedIn'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 300,
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Column(
                                children: [
                                  Text(
                                    'To Collaborate, email us:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text('collaborate[at]uidai[dot]net[dot]in'),
                                  SizedBox(height: 16),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'UIDAI Head Office',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                      'Bangla Sahib Road, Behind Kali Mandir, Gole Market, New Delhi - 110001'),
                                ],
                              ),
                              SizedBox(
                                width: 250,
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 16),
                                  Text(
                                    'Regional Offices',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                      'UIDAI Regional Office, Delhi: Ground Floor, Supreme Court Metro Station, Pragati Maidan, New Delhi-110001'),
                                  SizedBox(height: 16),
                                ],
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                          Divider(color: Colors.black),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Website Policy'),
                              Text('Terms & Conditions'),
                              Text('Privacy Policy'),
                              Text('Hyperlinking Policy'),
                              Text('Copyright Policy'),
                              Text('Disclaimer'),
                              Text('Help'),
                              Text('Feedback'),
                              Text('Sitemap'),
                            ],
                          ),
                          Divider(color: Colors.black),
                          Row(
                            children: [
                              SizedBox(
                                width: 420,
                              ),
                              Text(
                                  'Government of India: MyGov | National Portal of India | Digital India | GST.gov.in | DBT Bharat'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Footer content, always visible
        ],
      ),
    );
  }

  Widget _buildAadhaarCard({
    required String title,
    required String description,
    required String actionText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0), // Add padding here
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: 10),
              Text(description, style: TextStyle(fontSize: 14)),
              SizedBox(height: 10),
              Text(actionText,
                  style: TextStyle(fontSize: 16, color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQ({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0), // Add padding here
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: 10),
              Text(content, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create DropdownButton widget
  Widget _buildDropdownButton(String value, List<String> items) {
    return DropdownButton<String>(
      dropdownColor: Colors.blue[900],
      value: value,
      style: TextStyle(color: Colors.white),
      iconEnabledColor: Colors.white,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (_) {},
    );
  }
}
