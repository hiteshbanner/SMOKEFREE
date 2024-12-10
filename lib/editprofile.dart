import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'ip.dart';

class UppldPage extends StatefulWidget {
  final String? name = user_name;
  final String? age = user_age;
  final String? gender = user_gender;
  final String? contact = user_cont;
  final String? email = user_email;
  final String? base64Image = user_dp;
  // Language code: "0" for English, "1" for Tamil

  @override
  _UppldPageState createState() => _UppldPageState();
}

class _UppldPageState extends State<UppldPage> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController genderController;
  late TextEditingController contactController;
  late TextEditingController emailController;
  late String selectedLanguage;
  XFile? selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    ageController = TextEditingController(text: widget.age);
    genderController = TextEditingController(text: widget.gender);
    contactController = TextEditingController(text: widget.contact);
    emailController = TextEditingController(text: widget.email);

    selectedLanguage = lang == "1" ? 'தமிழ்' : 'English';
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    genderController.dispose();
    contactController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = image;
    });
  }

  String? _encodeImageToBase64() {
    if (selectedImage != null) {
      final bytes = File(selectedImage!.path).readAsBytesSync();
      return base64Encode(bytes);
    }
    return widget.base64Image; // Use existing base64 image if no new image is selected
  }

  Future<void> _handleSave() async {
    final String name = nameController.text.trim();
    final String age = ageController.text.trim();
    final String gender = genderController.text.trim();
    final String contact = contactController.text.trim();
    final String email = emailController.text.trim();
    final String language = selectedLanguage == 'தமிழ்' ? '1' : '0';
    final String? base64Image = _encodeImageToBase64();

    // Save profile image
    if (base64Image != null) {
      await _uploadProfileImage(base64Image);
    }

    // Save other details
    await _uploadUserDetails(name, age, gender, contact, email, language);
  }

  Future<void> _uploadProfileImage(String base64Image) async {
    final Uri imageApiUrl = Uri.parse(ip+'img_upld.php'); // Replace with your API URL
    final Map<String, String> data = {
      'username': userid ?? '',
      'image': base64Image,
    };

    try {
      final response = await http.post(
        imageApiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Handle successful response
        print('Profile image uploaded successfully');
      } else {
        // Handle error response
        print('Failed to upload profile image: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error occurred while uploading profile image: $e');
    }
  }

  Future<void> _uploadUserDetails(String name, String age, String gender, String contact, String email, String language) async {
    final Uri detailsApiUrl = Uri.parse(ip+'edit.php'); // Replace with your API URL
    final Map<String, String> data = {
      'username': userid ?? '',
      'name': name,
      'age': age,
      'gender': gender,
      'contact': contact,
      'email': email,
      'lang': language,
    };

    try {
      final response = await http.post(
        detailsApiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Handle successful response
        print('User details saved successfully');
      } else {
        // Handle error response
        print('Failed to save user details: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error occurred while saving user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 65,
              backgroundImage: selectedImage != null
                  ? FileImage(File(selectedImage!.path))
                  : widget.base64Image != null && widget.base64Image!.isNotEmpty
                  ? MemoryImage(base64Decode(widget.base64Image!)) as ImageProvider
                  : AssetImage('assets/pt.png'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: _pickImage,
              child: Column(
                children: [
                  Icon(Icons.add_a_photo, size: 50),
                  Text('Click to change DP', style: TextStyle(fontFamily: 'Amethysta', fontSize: 18.0)),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildFormField('Name:', nameController),
            _buildFormField('Age:', ageController),
            _buildFormField('Gender:', genderController),
            _buildFormField('Contact:', contactController),
            _buildFormField('Email:', emailController),
            SizedBox(height: 20),
            _buildLanguageSelection(),
            Spacer(),
            ElevatedButton(
              onPressed: _handleSave,
              child: Text('Save', style: TextStyle(fontFamily: 'Amethysta', fontSize: 18.0)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontFamily: 'Amethysta', fontSize: 18.0)),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              style: TextStyle(fontFamily: 'Amethysta', fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelection() {
    return Row(
      children: [
        Text('Language:', style: TextStyle(fontFamily: 'Amethysta', fontSize: 18.0)),
        SizedBox(width: 20),
        Expanded(
          child: Row(
            children: [
              Radio<String>(
                value: 'English',
                groupValue: selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    selectedLanguage = value ?? 'English';
                  });
                },
              ),
              Text('English', style: TextStyle(fontFamily: 'Amethysta', fontSize: 16.0)),
              Radio<String>(
                value: 'தமிழ்',
                groupValue: selectedLanguage,
                onChanged: (String? value) {
                  setState(() {
                    selectedLanguage = value ?? 'English';
                  });
                },
              ),
              Text('தமிழ்', style: TextStyle(fontFamily: 'Amethysta', fontSize: 16.0)),
            ],
          ),
        ),
      ],
    );
  }
}
