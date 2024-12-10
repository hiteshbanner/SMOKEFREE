import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:smokefree/patientlisr.dart';
import 'package:smokefree/patview.dart';
import 'ip.dart';
import 'dprof.dart';
import 'vid_upld.dart'; // Adjust the import as needed

class DoctorHomePage extends StatefulWidget {
  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  int _currentIndex = 0; // Index to keep track of selected bottom navigation item

  List<Patient> _patients = [];
  int _totalPatients = 0;
  int _malePatients = 0;
  int _femalePatients = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // Fetch patient data
      final String patientUrl = ip + 'dhome.php'; // Replace with your API URL
      final patientResponse = await http.post(Uri.parse(patientUrl));
      if (patientResponse.statusCode == 200) {
        final List<dynamic> patientsJson = json.decode(patientResponse.body);
        setState(() {
          _patients =
              patientsJson.map((json) => Patient.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load patients');
      }

      // Fetch patient counts
      final String countUrl = ip + 'dhomecnt.php'; // Replace with your API URL
      final countResponse = await http.post(Uri.parse(countUrl),
          body: {'username': 'username'}); // Update 'username' accordingly
      if (countResponse.statusCode == 200) {
        final String countsString = countResponse.body;

        // Split the response string into a list
        final List<String> counts = countsString.split(',')
            .map((s) => s.trim())
            .toList(); // Trim each substring

        // Parsing the counts and handling slicing
        if (counts.length >= 3) {
          _totalPatients = int.parse(counts[0].trim().substring(1));
          _malePatients = int.parse(counts[1].trim());
          _femalePatients =
              int.parse(counts[2].trim().substring(0, counts[2].length - 1));

          setState(() {});
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to load counts');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
      SystemNavigator.pop(); // Closes the app
      return false; // Prevents further back navigation
    },
    child: Scaffold(
      appBar: _currentIndex == 0
          ? PreferredSize(
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
      )
          : null,
      body: _buildBody(),
      bottomNavigationBar: _buildCustomBottomAppBar(),
    ));
  }

  Widget _buildBody() {
    return _currentIndex == 0
        ? _buildHomeContent()
        : _currentIndex == 1
        ? CameraPage()
        : DoctorProfilePage(username: doctid,);
  }

  Widget _buildCustomBottomAppBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Container(
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0xFF82A8D2),
            width: 2.0,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0)
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Color(0xFF82A8D2)),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.camera_alt, color: Color(0xFF82A8D2)),
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Color(0xFF82A8D2)),
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCounterBox('Patients', _totalPatients.toString()),
                    _buildCounterBox('Male', _malePatients.toString()),
                    _buildCounterBox('Female', _femalePatients.toString()),
                  ],
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Journey towards well-being and healing',
                        style: TextStyle(
                          fontFamily: 'Amethysta',
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Image.asset(
                        'assets/doctor.png',
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Patients',
                  style: TextStyle(
                    fontFamily: 'Amethysta',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF272626),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PatientSearchPage()),
                    );
                  },
                  child: Text(
                    'See More...',
                    style: TextStyle(
                      fontFamily: 'Amethysta',
                      fontSize: 20,
                      color: Color(0xFF81A7D1),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _patients.length,
                itemBuilder: (context, index) {
                  final patient = _patients[index];
                  return _buildPatientCard(
                    patient.user,
                    patient.name,
                    patient.age,
                    patient.imagePath,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterBox(String label, String count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Amethysta',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF272626),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 1.5,
              ),
            ),
            child: Center(
              child: Text(
                count,
                style: TextStyle(
                  fontFamily: 'Amethysta',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF81A7D1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCard(String user,String name, int age, String imagePath) {
    return GestureDetector(
      onTap: () {
        userid = user;
        // Navigate to patview() when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PatView()), // Pass any necessary data
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              CircleAvatar(
                radius: 35,
                backgroundImage: (imagePath != null && isValidBase64(imagePath))
                    ? MemoryImage(Uint8List.fromList(base64Decode(imagePath)))
                    : AssetImage('assets/poo.png') as ImageProvider,
              ),
              SizedBox(height: 10),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Amethysta',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF272626),
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '$age yrs',
                style: TextStyle(
                  fontFamily: 'Amethysta',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF81A7D1),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  class Patient {
    final String user;
  final String name;
  final int age;
  final String imagePath;

  Patient({required this.user,required this.name, required this.age, required this.imagePath});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      user: json['username'],
      name: json['name'],
      age: int.parse(json['age']),
      imagePath: json['dp'],
    );
  }
}
bool isValidBase64(String base64String) {
  try {
    final decodedBytes = base64Decode(base64String);
    return decodedBytes.isNotEmpty;
  } catch (e) {
    return false; // Return false if base64 decoding fails
  }
}

