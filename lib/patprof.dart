import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smokefree/secondpage.dart';

import 'ip.dart';
import 'editprofile.dart';
import 'patlog.dart';

class PatProfPage extends StatefulWidget {
  final String username = userid;


  @override
  _PatProfPageState createState() => _PatProfPageState();
}

class _PatProfPageState extends State<PatProfPage> {
  late String name, email, contact, age, gender;
  Uint8List _imageBytes = Uint8List(0); // Initialize with an empty Uint8List
  bool _isLoading = true;
  String t1 = "";
  String t2 = "";
  String t3 = "";
  String t4 = "";
  String t5 = "";


  @override
  void initState() {
    super.initState();
    fetchData(widget.username);
    _setLocalizedText();
  }
  void _setLocalizedText() {
    if (lang == "1") {
      t1 = "பெயர்:";
      t2 = "வயது:";
      t3 = "பாலினம்:";
      t4 = "தொலைபேசி:";
      t5 = "மின்னஞ்சல்:";

    } else {
      t1 = "Name:";
      t2 = "Age:";
      t3 = "Gender";
      t4 = "Phone No:";
      t5 = "Email:";

    }
  }
  Future<void> fetchData(String username) async {
    final apiUrl = ip + 'prof.php'; // Replace with your API endpoint

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'username': username},
      );

      if (response.statusCode == 200) {
        print(response.body);

        // Split the comma-separated response
        final values = response.body.split(',');

        if (values.length >= 7) {
          setState(() {
            name = values[0].trim().substring(1,values[0].length);
            contact = values[1];
            age = values[2];
            email = values[3];
            gender = values[6].trim().substring(0,values[6].length-1);

            try {
              // Handle base64 image if it's present
              _imageBytes = values[4].isNotEmpty
                  ? base64Decode(values[4])
                  : Uint8List(0); // Empty image if not present
            } catch (e) {
              // Handle base64 decode error
              print('Base64 decode error: $e');
              _imageBytes = Uint8List(0); // Set to empty image
            }

            _isLoading = false;
          });
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load profile data');
      }
    } catch (e) {
      // Handle any errors during fetch
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = lang == '1' ? 'Profile' : 'Profile';
    final String editText = lang == '1' ? 'திருத்தவும்' : 'Edit';
    final String logoutText = lang == '1' ? 'உடனடி வெளியேறல்' : 'Logout';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
            ),
            child: Container(
              color: Color(0xFF82A8D2), // Background color
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        user_name = name;
                        user_cont = contact;
                        user_age = age;
                        user_email = email;
                        user_gender = gender;
                        user_dp = base64Encode(_imageBytes);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UppldPage()),
                        );
                      },
                      child: Image.asset('assets/edt.png', width: 40.0, height: 40.0),
                    ),
                    IconButton(
                      icon: Icon(Icons.exit_to_app, color: Colors.white),
                      onPressed: () {
                        _showLogoutDialog();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20.0),
              child: CircleAvatar(
                radius: 75,
                backgroundImage: _imageBytes.isNotEmpty
                    ? MemoryImage(_imageBytes)
                    : AssetImage('assets/pt.png') as ImageProvider,
                backgroundColor: Color(0xFFE7E6E6),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow(t1, name),
                  buildInfoRow(t2, age),
                  buildInfoRow(t3, gender),
                  buildInfoRow(t4, contact),
                  buildInfoRow(t5, email),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Amethysta',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Amethysta',
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => secondpage()), // Replace with your login page
                );
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }
}
