import 'dart:convert';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:smokefree/deepbreathe.dart';
import 'package:smokefree/ip.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class DistractPage extends StatefulWidget {
  final String username=userid;




  @override
  _DistractPageState createState() => _DistractPageState();
}

class _DistractPageState extends State<DistractPage> {
  late VideoPlayerController _videoPlayerController;
  bool _isLoading = true;
  ChewieController? _chewieController;
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    fetchData(widget.username);
  }

  Future<void> fetchData(String username) async {
    String apiUrl = '${ip}discdstrct.php';

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
    final TextStyle textStyle = TextStyle(
      fontFamily: 'Amethysta',
      fontSize: 16.0,
      color: Color(0xFF2B2A2A),
    );

    final localizedTexts = lang == '1'
        ? {
      'title': 'கவனத்தை திருப்பு',
      'item1': '> பல் துலக்குங்கள்',
      'item2': '> சூயிங் கம்மை மெல்லுங்கள்',
      'item3': '> விசில் அல்லது ஹம் X5 முறை',
      'item4': '> இசையைக் கேளுங்கள்',
      'item5': '> உடற்பயிற்சி செய்யுங்கள்',
      'item6': '> 10 ஜம்பிங் ஜாக்குகளை 3 செட்\n   செய்யுங்கள்',
      'next': 'அடுத்து',
    }
        : {
      'title': 'Distract',
      'item1': '> Brush your teeth',
      'item2': '> Turn on music',
      'item3': '> Exercise',
      'item4': '> Do 3 sets of 10 jumping jacks',
      'item5': '> Chew gum',
      'item6': '> Whistle or hum X5 times',
      'next': 'Next',
    };

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF82A8D2), // App bar color
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Text(
                localizedTexts['title']!,
                style: TextStyle(
                  fontFamily: 'Amethysta',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC4252424),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: 350.0,
              height: 200.0,
              color: Colors.black,
              child: _chewieController != null
                  ? Chewie(controller: _chewieController!)
                  : Center(child: CircularProgressIndicator()),
            ),
            SizedBox(height: 10.0),
            // Content aligned to the left start
            Text(localizedTexts['item1']!, style: textStyle),
            SizedBox(height: 10.0),
            Text(localizedTexts['item2']!, style: textStyle),
            SizedBox(height: 10.0),
            Text(localizedTexts['item3']!, style: textStyle),
            SizedBox(height: 10.0),
            Text(localizedTexts['item4']!, style: textStyle),
            SizedBox(height: 10.0),
            Text(localizedTexts['item5']!, style: textStyle),
            SizedBox(height: 10.0),
            Text(localizedTexts['item6']!, style: textStyle),
            SizedBox(height: 20.0),
            Center(
              child: Image.asset(
                'assets/jj.png', // Replace with your image asset path
                width: 180.0,
                height: 120.0,
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeepBreathPage(

                      ),
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
                  localizedTexts['next']!,
                  style: TextStyle(
                    fontFamily: 'Amethysta',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0), // Padding to avoid overlap with bottom edge
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
