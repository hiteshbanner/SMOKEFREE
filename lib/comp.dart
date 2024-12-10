import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smokefree/comp2.dart';
import 'package:smokefree/ip.dart';

class CompPage extends StatefulWidget {
  final String username = userid; // Assuming userid is defined somewhere
  final int points = int.parse(user_pnts); // Assuming user_pnts is defined somewhere
  final String mon = user_mon; // Assuming user_mon is defined somewhere
  final String mon_sav = user_monsav; // Assuming user_monsav is defined somewhere
  final String rs = user_rs; // Assuming user_rs is defined somewhere

  @override
  _CompPageState createState() => _CompPageState();
}

class _CompPageState extends State<CompPage> {
  int _selectedCigaretteCount = 0;
  late int points;
  late double m, r, ms;

  @override
  void initState() {
    super.initState();
    points = widget.points;
    m = double.parse(widget.mon);
    r = double.parse(widget.rs);
    ms = double.parse(widget.mon_sav);
  }

  Future<void> _submitData() async {
    if (_selectedCigaretteCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a cigarette count")),
      );
      return;
    }

    double b = 0;
    if (_selectedCigaretteCount == 1) {
      points += 25;
      b = m - r;
    } else if (_selectedCigaretteCount == 2) {
      points += 10;
      b = m - (r * 5);
    } else if (_selectedCigaretteCount == 3) {
      points += 5;
      b = m - (r * 10);
    } else if (_selectedCigaretteCount == 4) {
      b = m - (r * 15);
    } else if (_selectedCigaretteCount == 5) {
      points = points > 5 ? points - 5 : 0;
      b = m - (r * 20);
    }

    final double newMonSav = (ms + b) <= 0 ? 0 : ms + b;

    final now = DateTime.now();
    final String formattedDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    try {
      final response = await http.post(
        Uri.parse(ip + 'comp.php'),
        body: {
          'username': widget.username,
          'points': points.toString(),
          'mon_sav': newMonSav.toString(),
          'log_dt': formattedDate,
        },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody.toString().toLowerCase().contains("success")) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Comp2Page()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Points updation failed")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image at the top
            Container(
              margin: EdgeInsets.only(top: 32),
              child: Image.asset(
                'assets/cu.png',
                width: 400,
                height: 350,
              ),
            ),
            SizedBox(height: 20),
            // Cigarettes text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Text(
                lang == '1' ? 'சிகரெட் எண்ணிக்கை:' : 'No of Cigarettes:',
                style: TextStyle(
                  fontFamily: 'Amethysta',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E3D3D),
                ),
              ),
            ),
            // Radio Group
            Expanded(
              child: ListView(
                children: [
                  RadioListTile<int>(
                    title: Text("1"),
                    value: 1,
                    groupValue: _selectedCigaretteCount,
                    onChanged: (value) {
                      setState(() {
                        _selectedCigaretteCount = value!;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  RadioListTile<int>(
                    title: Text(lang == '1' ? "5 க்கும் குறைவாக" : "less than 5"),
                    value: 2,
                    groupValue: _selectedCigaretteCount,
                    onChanged: (value) {
                      setState(() {
                        _selectedCigaretteCount = value!;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  RadioListTile<int>(
                    title: Text("5 - 10"),
                    value: 3,
                    groupValue: _selectedCigaretteCount,
                    onChanged: (value) {
                      setState(() {
                        _selectedCigaretteCount = value!;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  RadioListTile<int>(
                    title: Text("10 - 15"),
                    value: 4,
                    groupValue: _selectedCigaretteCount,
                    onChanged: (value) {
                      setState(() {
                        _selectedCigaretteCount = value!;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  RadioListTile<int>(
                    title: Text("> 15"),
                    value: 5,
                    groupValue: _selectedCigaretteCount,
                    onChanged: (value) {
                      setState(() {
                        _selectedCigaretteCount = value!;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ],
              ),
            ),
            // Instruction Text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                lang == '1' ? "உங்கள் எண்ணங்களை எதிர்க்க உதவுவோம்!" : "Let's help you to resist your thoughts!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Amethysta',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E3D3D),
                ),
              ),
            ),
            // Start Button
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF82A8D2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(
                  'Start',
                  style: TextStyle(
                    fontFamily: 'Amethysta',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
