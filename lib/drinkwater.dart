import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:smokefree/patient.dart';
import 'package:smokefree/ip.dart'; // Ensure this import points to where your IP is defined

class DrinkWaterPage extends StatefulWidget {
  final String username=userid;




  @override
  _DrinkWaterPageState createState() => _DrinkWaterPageState();
}

class _DrinkWaterPageState extends State<DrinkWaterPage> {
  ChewieController? _chewieController;
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    fetchData(widget.username);
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> fetchData(String username) async {
    String apiUrl = '${ip}discdrnk.php';

    try {
      final response = await http.post(Uri.parse(apiUrl), body: {'username': username});
      if (response.statusCode == 200) {
        String videoUrl = extractVideoUrlFromResponse(response.body);
        _playVideo(videoUrl);
      } else {
        print('Failed to fetch video.');
      }
    } catch (e) {
      print('Error fetching video: $e');
    }
  }

  String extractVideoUrlFromResponse(String response) {
    List<String> values = response.split(":");
    return '${ip}videos/${values[1].substring(9, values[1].length - 2)}';
  }

  void _playVideo(String videoUrl) {
    _videoController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoController!,
            autoPlay: true,
            looping: true,
          );
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    String title = lang == "1" ? "தண்ணீர் குடி மற்றும் பேசவும்" : "Drink water and Discuss";
    String description = lang == "1"
        ? "சிகரெட் பிடிக்க ஆசையா? அதற்கு பதிலாக ஹைட்ரேட்! கைகளையும் மனதையும் சுறுசுறுப்பாக வைத்திருக்கவும், பசியைக் கட்டுப்படுத்தவும் தண்ணீரைப் பருகவும்"
        : "Craving a cigarette? Hydrate instead! Sip water to keep hands and mind busy, curbing cravings";
    String footer = lang == "1" ? "நிறைய தண்ணீர் குடியுங்கள்!\uD83D\uDCA7" : "Drink a lot of water!💧";
    String item1 = lang == "1" ? "> செய்ய வேண்டிய ஒன்று" : "> It’s something to do";
    String item2 = lang == "1" ? "> இது உங்கள் இருமலைப் போக்க உதவும்" : "> It can help relieve your tickly cough";
    String item3 = lang == "1" ? "> சிற்றுண்டி சாப்பிடாமல் இருக்க \n   உங்களுக்கு உதவலாம்" : "> Might help you not to snack";
    String buttonText = lang == "1" ? "அடுத்து" : "Next";

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF82A8D2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Amethysta',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC4252424),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 350.0,
              height: 200.0,
              color: Colors.black,
              child: _chewieController != null
                  ? Chewie(controller: _chewieController!)
                  : Center(child: CircularProgressIndicator()),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: TextStyle(
                  fontFamily: 'Amethysta',
                  fontSize: 16.0,
                  color: Color(0xFF454545),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              footer,
              style: TextStyle(
                fontFamily: 'Amethysta',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF565656),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item1,
                  style: TextStyle(
                    fontFamily: 'Amethysta',
                    fontSize: 16.0,
                    color: Color(0xFF2B2A2A),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  item2,
                  style: TextStyle(
                    fontFamily: 'Amethysta',
                    fontSize: 16.0,
                    color: Color(0xFF2B2A2A),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  item3,
                  style: TextStyle(
                    fontFamily: 'Amethysta',
                    fontSize: 16.0,
                    color: Color(0xFF2B2A2A),
                  ),
                ),
              ],
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Patient(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF82A8D2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  fixedSize: Size(150.0, 50.0),
                  elevation: 0,
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontFamily: 'Amethysta',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
