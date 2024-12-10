import 'package:flutter/material.dart';
import 'package:smokefree/seduc.dart';
import 'package:smokefree/selfmo.dart';
import 'package:smokefree/soc.dart';
import 'ip.dart';
import 'lev.dart';

class Motivation extends StatelessWidget {
  // Add this to capture the language

   // Default language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Main Image
            Image.asset(
              'assets/wn.png', // Replace with your asset path
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 40),
            // Horizontal Container
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First Vertical Column
                Column(
                  children: [
                    // Self Motivation
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelfMo(),
                          ),
                        );
                      },
                      child: Container(
                        width: 140,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/tm1.png', // Replace with your asset path
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(height: 5),
                            Text(
                              lang == "1" ? "சுய உந்துதல்" : "Self Motivation",
                              style: TextStyle(
                                fontFamily: 'Amethysta',
                                color: Color(0xFF252525),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Seduction
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Seduc(),
                          ),
                        );
                      },
                      child: Container(
                        width: 140,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/tm3.png', // Replace with your asset path
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(height: 5),
                            Text(
                              lang == "1" ? "ஆபத்து ரேடார்" : "Seduction",
                              style: TextStyle(
                                fontFamily: 'Amethysta',
                                color: Color(0xFF252525),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15),
                // Second Vertical Column
                Column(
                  children: [
                    // Leverage
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Lev(),
                          ),
                        );
                      },
                      child: Container(
                        width: 140,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/tm2.png', // Replace with your asset path
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(height: 5),
                            Text(
                              lang == "1" ? "முன்னேறுங்கள்" : "Leverage",
                              style: TextStyle(
                                fontFamily: 'Amethysta',
                                color: Color(0xFF252525),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Social
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Social(),
                          ),
                        );
                      },
                      child: Container(
                        width: 140,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/tm4.png', // Replace with your asset path
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(height: 5),
                            Text(
                              lang == "1" ? "சமூக ஆதரவு" : "Social",
                              style: TextStyle(
                                fontFamily: 'Amethysta',
                                color: Color(0xFF252525),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
