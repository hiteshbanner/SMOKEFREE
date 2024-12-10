import 'dart:convert';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:smokefree/ip.dart';
import 'package:smokefree/patient.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class Comp2Page extends StatefulWidget {
  final String username= userid;




  @override
  _Comp2PageState createState() => _Comp2PageState();
}

class _Comp2PageState extends State<Comp2Page> {
  late VideoPlayerController _controller;
  bool _isLoading = true;
  String _videoUrl = '';
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
    final String title = lang == '1' ? '' : '';
    final String buttonText = lang == '1' ? 'அடுத்து' : 'Go to Home';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(height: 60.0),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Amethysta',
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC4252424),
              ),
              textAlign: TextAlign.center,
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
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
