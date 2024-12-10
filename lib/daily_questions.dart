import 'package:flutter/material.dart';
import 'package:smokefree/abs.dart';
import 'package:smokefree/comp.dart'; // Import CompPage class

class DailyQuePage extends StatefulWidget {
  @override
  _DailyQuePageState createState() => _DailyQuePageState();
}

class _DailyQuePageState extends State<DailyQuePage> {
  int selectedMoodIndex = -1; // Track selected mood index
  int selectedScale = -1; // Track selected scale

  // Function to show warning message
  void _showWarningMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('Please answer both Question 1 and Question 2 before proceeding.'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Validate if both questions are answered
  bool _isFormValid() {
    return selectedMoodIndex != -1 && selectedScale != -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Mindful daily reflection',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Amethysta',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF323131),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Image.asset(
                  'assets/dly.png',
                  width: 320,
                  height: 320,
                ),
              ),

              // Question 1: Mood
              SizedBox(height: 20),
              _buildQuestion('Q1. What’s your mood today?'),
              Container(
                width: double.infinity,
                height: 70,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMoodImageButton(0, 'assets/e1.png'),
                      _buildMoodImageButton(1, 'assets/e2.png'),
                      _buildMoodImageButton(2, 'assets/e3.png'),
                      _buildMoodImageButton(3, 'assets/e4.png'),
                      _buildMoodImageButton(4, 'assets/e5.png'),
                    ],
                  ),
                ),
              ),

              // Question 2: Craving Scale
              SizedBox(height: 20),
              _buildQuestion('Q2. On a scale of 1-5, how is your craving today?'),
              Container(
                width: double.infinity,
                height: 65,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFF82A8D2),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildScaleButton(1),
                    _buildScaleButton(2),
                    _buildScaleButton(3),
                    _buildScaleButton(4),
                    _buildScaleButton(5),
                  ],
                ),
              ),

              // Question 3: Smoke-Free Day
              SizedBox(height: 20),
              _buildQuestion('Q3. Have you added another smoke-free day?'),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: _buildActionButton('Yes', () {
                        if (_isFormValid()) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AbsPage()));
                        } else {
                          _showWarningMessage(context); // Show warning if form is invalid
                        }
                      }),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: _buildActionButton('No', () {
                        if (_isFormValid()) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CompPage()));
                        } else {
                          _showWarningMessage(context); // Show warning if form is invalid
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(String question) {
    return Text(
      question,
      style: TextStyle(
        fontFamily: 'Amethysta',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF323131),
      ),
    );
  }

  Widget _buildMoodImageButton(int index, String imagePath) {
    bool isSelected = selectedMoodIndex == index; // Check if selected
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMoodIndex = index; // Update selected mood
        });
      },
      child: Container(
        width: 60,
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent, // Highlight selected
            width: 2.0,
          ),
        ),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildScaleButton(int scale) {
    bool isSelected = selectedScale == scale;
    Color selectedColor;

    switch (scale) {
      case 1:
        selectedColor = Colors.green;
        break;
      case 2:
        selectedColor = Colors.lightGreen;
        break;
      case 3:
        selectedColor = Colors.yellow;
        break;
      case 4:
        selectedColor = Colors.orange;
        break;
      case 5:
        selectedColor = Colors.red;
        break;
      default:
        selectedColor = Colors.transparent;
    }

    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedScale = scale; // Update selected scale
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? selectedColor : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(600),
        ),
        padding: EdgeInsets.zero,
      ),
      child: Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          border: Border.all(
            color: isSelected ? selectedColor : Color(0xFF605858),
            width: 2,
          ),
        ),
        child: Text(
          '$scale',
          style: TextStyle(
            fontFamily: 'Amethysta',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF323131),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF82A8D2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        textStyle: TextStyle(
          fontFamily: 'Amethysta',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
