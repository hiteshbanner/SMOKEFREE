import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:smokefree/ip.dart';

class Biweekly extends StatefulWidget {
  final String username=userid;

  final String ind = user_ind;



  @override
  _BiweeklyState createState() => _BiweeklyState();
}

class _BiweeklyState extends State<Biweekly> {
  String? _selectedQ1;
  String? _selectedQ2;
  String? _selectedQ3;
  String? _selectedQ4;
  String? _selectedQ5;
  String? _selectedQ6;

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
                padding: const EdgeInsets.only(top: 40.0, left: 20.0),
                child: Text(
                  '',
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
        padding: EdgeInsets.only(bottom: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  lang == '1'
                      ? 'இருவார பிரதிபலிப்பு'
                      : 'Mindful biweekly reflection',
                  style: TextStyle(
                    fontFamily: 'Amethysta',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildQuestion(
              lang == '1'
                  ? 'Q1. நடந்த பிறகு எவ்வளவு சீக்கிரம் முதல் சிகரெட் புகைப்பீர்கள்?'
                  : 'Q1. How soon after walking do you smoke first cigarette?',
              [
                lang == '1'
                    ? '5 நிமிடங்களுக்குள்'
                    : 'Within 5 minutes',
                lang == '1'
                    ? '5-30 நிமிடங்கள்'
                    : '5 - 30 minutes',
                lang == '1'
                    ? '31-60 நிமிடங்கள்'
                    : '31 - 60 minutes',
              ],
                  (value) {
                setState(() {
                  _selectedQ1 = value;
                });
              },
              _selectedQ1,
            ),
            _buildQuestion(
              lang == '1'
                  ? 'Q2. தடைசெய்யப்பட்ட இடங்களில் புகைபிடிப்பதைத் தவிர்ப்பது உங்களுக்கு கடினமாக இருக்கிறதா?'
                  : 'Q2. Do you find it difficult to refrain from smoking in places where it is forbidden?',
              [
                lang == '1' ? 'ஆம்' : 'Yes',
                lang == '1' ? 'இல்லை' : 'No',
              ],
                  (value) {
                setState(() {
                  _selectedQ2 = value;
                });
              },
              _selectedQ2,
            ),
            _buildQuestion(
              lang == '1'
                  ? 'Q3. எந்த சிகரெட்டை கைவிடுவதை நீங்கள் வெறுக்கிறீர்கள்?'
                  : 'Q3. Which cigarette would you hate to give up?',
              [
                lang == '1' ? 'கலையின் முதல்' : 'The first in the morning',
                lang == '1' ? 'மற்றவை' : 'Any other',
              ],
                  (value) {
                setState(() {
                  _selectedQ3 = value;
                });
              },
              _selectedQ3,
            ),
            _buildQuestion(
              lang == '1'
                  ? 'Q4. ஒரு நாளைக்கு எத்தனை சிகரெட் பிடிக்கிறீர்கள்?'
                  : 'Q4. How many cigarettes a day do you smoke?',
              [
                lang == '1' ? '10 அல்லது குறைவாக' : '10 or less',
                lang == '1' ? '11-20' : '11 - 20',
                lang == '1' ? '21-30' : '21 - 30',
                lang == '1' ? '31 அல்லது அதற்கு மேல்' : '31 or more',
              ],
                  (value) {
                setState(() {
                  _selectedQ4 = value;
                });
              },
              _selectedQ4,
            ),
            _buildQuestion(
              lang == '1'
                  ? 'Q5. நீங்கள் காலையில் அடிக்கடி புகைப்பிடிப்பீர்களா?'
                  : 'Q5. Do you smoke more frequently in the morning?',
              [
                lang == '1' ? 'ஆம்' : 'Yes',
                lang == '1' ? 'இல்லை' : 'No',
              ],
                  (value) {
                setState(() {
                  _selectedQ5 = value;
                });
              },
              _selectedQ5,
            ),
            _buildQuestion(
              lang == '1'
                  ? 'Q6. நாள் முழுவதும் நீங்கள் உடல்நிலை சரியில்லாமல் படுக்கையில் இருந்தாலும் புகைப்பிடிப்பீர்களா?'
                  : 'Q6. Do you smoke even if you are sick in bed most of the day?',
              [
                lang == '1' ? 'ஆம்' : 'Yes',
                lang == '1' ? 'இல்லை' : 'No',
              ],
                  (value) {
                setState(() {
                  _selectedQ6 = value;
                });
              },
              _selectedQ6,
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  int score = _calculateScore();
                  if (score == -1) {
                    _showDialog('Fields cannot be empty!');
                  } else {
                    await _sendScore(score);
                    _showResultDialog(score);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  backgroundColor: Color(0xFF81A7D1),
                ),
                child: Text(
                  lang == '1' ? 'பதிவு செய்' : 'Submit',
                  style: TextStyle(
                    fontFamily: 'Amethysta',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(String question, List<String> options, ValueChanged<String?> onChanged, String? groupValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontFamily: 'Amethysta',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: options.map((option) {
              return Row(
                children: [
                  Radio<String>(
                    value: option,
                    groupValue: groupValue,
                    onChanged: onChanged,
                  ),
                  Text(
                    option,
                    style: TextStyle(
                      fontFamily: 'Amethysta',
                      fontSize: 16,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  int _calculateScore() {
    int score = 0;
    int questionsAnswered = 0;

    if (_selectedQ1 != null) {
      score += _selectedQ1 == 'Within 5 minutes' ? 3 : _selectedQ1 == '5 - 30 minutes' ? 2 : 1;
      questionsAnswered++;
    }
    if (_selectedQ2 != null) {
      score += _selectedQ2 == 'Yes' ? 1 : 0;
      questionsAnswered++;
    }
    if (_selectedQ3 != null) {
      score += _selectedQ3 == 'The first in the morning' ? 1 : 0;
      questionsAnswered++;
    }
    if (_selectedQ4 != null) {
      score += _selectedQ4 == '10 or less' ? 0 : _selectedQ4 == '11 - 20' ? 1 : _selectedQ4 == '21 - 30' ? 2 : 3;
      questionsAnswered++;
    }
    if (_selectedQ5 != null) {
      score += _selectedQ5 == 'Yes' ? 1 : 0;
      questionsAnswered++;
    }
    if (_selectedQ6 != null) {
      score += _selectedQ6 == 'Yes' ? 1 : 0;
      questionsAnswered++;
    }

    return questionsAnswered == 6 ? score : -1;
  }

   // Add this import at the top of your file

  Future<void> _sendScore(int score) async {
    String url = "";

    // Determine the correct URL based on user_ind
    if (int.tryParse(user_ind) != null && int.tryParse(user_ind)! > 11) {
      url = ip + "biweek.php";
    } else {
      url = ip + "bwk" + user_ind + ".php";
    }

    // Format the date to YYYY-MM-DD
    final String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Prepare the request body according to PHP expectations
    final requestBody = jsonEncode({
      'username': userid,
      'bwk': score,
      'bwk_dt': formattedDate  // Use the formatted date
    });

    print("Constructed URL: $url");
    print("Username: $userid");
    print("Score: $score");
    print("Request body: $requestBody");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody,
      );

      // Log the response details for debugging
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode != 200) {
        print("Error response body: ${response.body}");
        throw Exception('Failed to submit score. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Log and handle errors
      print("Error occurred: $e");
      throw Exception('Failed to submit score');
    }
  }



  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            lang == '1' ? 'எதிரொலித்தல்' : 'Alert',
            style: TextStyle(
              fontFamily: 'Amethysta',
              fontSize: 18,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              fontFamily: 'Amethysta',
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                lang == '1' ? 'அங்கீகாரம்' : 'OK',
                style: TextStyle(
                  fontFamily: 'Amethysta',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showResultDialog(int score) {
    String message = '';

    if (score < 10) {
      message = lang == '1' ? 'அதிகமாக புகைப்பிடிக்க வேண்டாம்!' : 'Please reduce smoking!';
    } else if (score < 20) {
      message = lang == '1' ? 'மீதமுள்ள திருத்தங்களை செய்யவும்.' : 'Consider making some changes.';
    } else {
      message = lang == '1' ? 'நீங்கள் முன்னேறி வருகிறீர்கள்!' : 'You are progressing well!';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            lang == '1' ? 'முடிவு' : 'Result',
            style: TextStyle(
              fontFamily: 'Amethysta',
              fontSize: 18,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              fontFamily: 'Amethysta',
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to the previous page
              },
              child: Text(
                lang == '1' ? 'சரி' : 'OK',
                style: TextStyle(
                  fontFamily: 'Amethysta',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
