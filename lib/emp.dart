import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart'; // Import chewie

import 'delay.dart';
import 'ip.dart';

class EmpPage extends StatefulWidget {
  final String username = userid;
   // Added to handle language

   // Constructor to accept language parameter

  @override
  _EmpPageState createState() => _EmpPageState();
}

class _EmpPageState extends State<EmpPage> {
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
    String apiUrl = '${ip}discemp.php';

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
    String title = lang == "1" ? "உங்கள் பயணத்தை மேம்படுத்துங்கள்" : "Empower your journey";
    String subtitle = lang == "1"
        ? "புகைபிடிப்பதை விட்டுவிட சிறந்த நேரம் இதுதான், நீங்கள் தொடங்கிய நாள் இன்றுதான் அதை நிறுத்த இரண்டாவது சிறந்த நேரம்"
        : "The best time to quit smoking was the day you started. The second best time to quit is today.";
    String buttonText = lang == "1" ? "அடுத்து" : "Next";

    return Scaffold(
      body: Column(
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
          SizedBox(height: 48.0),
          LayoutBuilder(
            builder: (context, constraints) {
              return Text(
                title,
                style: TextStyle(
                  fontFamily: 'Amethysta',
                  fontSize: constraints.maxWidth * 0.07, // Responsive font size
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC4252424),
                ),
                textAlign: TextAlign.center,
              );
            },
          ),
          SizedBox(height: 30.0),
          LayoutBuilder(
            builder: (context, constraints) {
              return Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'Amethysta',
                  fontSize: constraints.maxWidth * 0.05, // Responsive font size
                  color: Color(0xFF454545),
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              );
            },
          ),
          SizedBox(height: 40.0),
          Container(
            width: 350.0,
            height: 200.0,
            color: Colors.black,
            child: _chewieController != null
                ? Chewie(controller: _chewieController!)
                : Center(child: CircularProgressIndicator()),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DelayPage(),
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
          SizedBox(height: 112.0),
        ],
      ),
    );
  }
}
