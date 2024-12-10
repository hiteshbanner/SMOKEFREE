import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:smokefree/secondpage.dart';

import 'ip.dart';

class DoctorProfilePage extends StatefulWidget {
  final String username;

  DoctorProfilePage({required this.username});

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  String _name = '';
  String _contact = '';
  String _age = '';
  String _gender = '';
  String _email = '';
  String _imagePath = 'assets/yi.png'; // Default image

  @override
  void initState() {
    super.initState();
    _fetchData(widget.username);
  }

  Future<void> _fetchData(String username) async {
    final String apiUrl = ip+'dprof.php'; // Replace with your API URL

    try {
      final response = await http.post(Uri.parse(apiUrl), body: {'username': doctid});
      if (response.statusCode == 200) {
        final List<String> values = response.body.split(', ');

        if (values.length >= 5) {
          setState(() {
            _name = values[0].trim().substring(1,values[0].length);
            _contact = values[1].trim();
            _age = values[2].trim();
            _email = values[3].trim();
            _gender = values[4].trim().substring(0,values[4].length-1);

            // Update imagePath if needed (assuming the image path is included in the response)
            // _imagePath = values[5].trim();
          });
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation'),
          content: Text('Are you sure you want to exit?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => secondpage()),
                );

                // Change to your login route
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
              decoration: BoxDecoration(
                color: Color(0xFF81A7D1),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 20.0,bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '',
                      style: TextStyle(
                        fontFamily: 'Amethysta',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.exit_to_app, color: Colors.white),
                      onPressed: _showExitDialog,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20.0),
              child: CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage(_imagePath), // Use imagePath from API response
                backgroundColor: Color(0xFFE7E6E6),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('Name:', _name),
                  buildInfoRow('Age:', _age),
                  buildInfoRow('Gender:', _gender),
                  buildInfoRow('Phone No:', _contact),
                  buildInfoRow('E-mail:', _email),
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
}
