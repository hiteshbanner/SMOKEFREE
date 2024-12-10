import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:smokefree/ip.dart';
import 'package:smokefree/patient.dart';

class AbsPage extends StatefulWidget {
  final String username=userid;
  final int points=int.parse(user_pnts);
  final String mon=user_mon;



  @override
  _AbsPageState createState() => _AbsPageState();
}

class _AbsPageState extends State<AbsPage> {
  final TextEditingController reason1Controller = TextEditingController();
  final TextEditingController reason2Controller = TextEditingController();
  final TextEditingController reason3Controller = TextEditingController();
  String url = ip+"abs.php";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Container(
                width: 400,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/su.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Text(
                  lang == "1"
                      ? 'நீங்கள் புகைபிடிக்காமல் இருந்ததற்குகான காரணங்கள்?'
                      : 'Reasons for your abstinence?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Amethysta',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E3D3D),
                  ),
                ),
              ),
              _buildElegantTextField(lang == "1" ? 'காரணம் 1' : 'Reason 1', reason1Controller),
              SizedBox(height: 20),
              _buildElegantTextField(lang == "1" ? 'காரணம் 2' : 'Reason 2', reason2Controller),
              SizedBox(height: 20),
              _buildElegantTextField(lang == "1" ? 'காரணம் 3' : 'Reason 3', reason3Controller),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 60.0),
                child: ElevatedButton(
                  onPressed: _submitReasons,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF82A8D2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text(
                    lang == "1" ? 'தொடரவும்' : 'Continue',
                    style: TextStyle(
                      fontFamily: 'Amethysta',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildElegantTextField(String hintText, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Amethysta',
            fontSize: 18,
            color: Colors.grey[600],
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'Amethysta',
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Future<void> _submitReasons() async {
    // Get the current date
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    // Send the request
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'username': widget.username,
          'points': (widget.points + 50).toString(),
          'mon': widget.mon,
          'log_dt': formattedDate,
        },
      );

      // Handle the response
      if (response.statusCode == 200) {
        final String responseString = response.body;
        print(responseString);
        if (responseString.toLowerCase().contains("success")) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Points updated successfully!')));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Patient()),
          ); // Redirect to MainActivity2 equivalent
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Points updation failed')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Server error. Please try again.')));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $error')));
    }
  }
}
