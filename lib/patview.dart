import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smokefree/pft.dart';

import 'ip.dart';

class PatView extends StatefulWidget {
  final String username=userid;


  @override
  _PatViewState createState() => _PatViewState();
}

class _PatViewState extends State<PatView> {
  late TextEditingController _commentController;
  String name = '';
  String age = '';
  String gender = '';
  String phone = '';
  String email = '';
  int n = 0;
  List<int> arr = List.filled(12, 0);
  List<FlSpot> dataPoints = [];

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    fetchData(widget.username);
  }

  Future<void> fetchData(String username) async {
    try {
      final response = await http.post(
        Uri.parse(ip+'patview.php'),
        body: {'username': username},
      );

      if (response.statusCode == 200) {
        handleResponse(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void handleResponse(String response) {
    List<String> values = response.split(', ');

    setState(() {
      name = values[0].trim().substring(1,values[0].length);
      phone = values[1];
      age = values[2];
      email = values[3];
      gender = values[4];
      n = int.parse(values[5]);

      for (int i = 0; i < 12; i++) {
        if(i==11){
          arr[i] = int.parse(values[i + 6].trim().substring(0,values[i+6].length-1));
        }
        else{
        arr[i] = int.parse(values[i + 6].trim());
          }
      }

      // Creating the data points for the line chart
      dataPoints = List.generate(n, (i) => FlSpot(i.toDouble(), arr[i].toDouble()));
    });
  }

  void sendComment() async {
    String comment = _commentController.text.trim();

    if (comment.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse(ip+'docmsg.php'),
          body: {'username': widget.username, 'doc_msg': comment},
        );

        if (response.statusCode == 200) {
          // Handle success
          print('Comment sent successfully');
        } else {
          throw Exception('Failed to send comment');
        }
      } catch (error) {
        print('Error sending comment: $error');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Empty message cannot be sent')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
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
              color: Color(0xFF81A7D1),
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 20.0),
                child: Text(
                  '\n',
                  style: TextStyle(
                    fontFamily: 'Amethysta',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/pt.png'),
            ),
            SizedBox(height: 20),
            // Display patient details
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailLabel('Name:'),
                    _buildDetailLabel('Age:'),
                    _buildDetailLabel('Gender:'),
                    _buildDetailLabel('Ph No:'),
                    _buildDetailLabel('E-mail:'),
                  ],
                ),
                SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailValue(name),
                    _buildDetailValue(age),
                    _buildDetailValue(gender),
                    _buildDetailValue(phone),
                    _buildDetailValue(email),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Biweekly Progress',
              style: TextStyle(
                fontFamily: 'Amethysta',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Line Chart for Biweekly Progress
            Container(
              height: 190,
              width: 250,
              child: dataPoints.isNotEmpty
                  ? LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: dataPoints,
                      isCurved: true,
                      color: Colors.blue,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: true),
                    ),
                  ],
                ),
              )
                  : Center(child: CircularProgressIndicator()),
            ),
            SizedBox(height: 20),
            // Health and PFT section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('Health', style: _buildTextStyle()),
                    SizedBox(height: 10),
                    Image.asset('assets/lungs.png', width: 100, height: 100),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PftScreen()),
                    );
                  },
                  child: Column(
                    children: [
                      Text('PFT', style: _buildTextStyle()),
                      SizedBox(height: 10),
                      Image.asset('assets/pftt.png', width: 100, height: 100),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Comments section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: '+ Add Comments',
                        contentPadding: EdgeInsets.all(10),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: sendComment,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _buildTextStyle() {
    return TextStyle(
      fontFamily: 'Amethysta',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  Widget _buildDetailLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Amethysta',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDetailValue(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        value,
        style: TextStyle(
          fontFamily: 'Amethysta',
          fontSize: 20,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
