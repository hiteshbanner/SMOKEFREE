import 'package:flutter/material.dart';

class FacultyRegister extends StatefulWidget {
  @override
  _FacultyRegisterState createState() => _FacultyRegisterState();
}

class _FacultyRegisterState extends State<FacultyRegister> {
  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController dateOfJoiningController = TextEditingController();
  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  // Status dropdown selection
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/gv.png', // Replace with your logo asset path
              height: 40,
            ),
            SizedBox(width: 8),
            Text(
              'KRP',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: CircleAvatar(
              backgroundImage: NetworkImage('https://example.com/poo.jpg'), // Replace with image URL
            ),
            onPressed: () {},
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Center(
              child: Text(
                'Faculty Registration Form',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Profile picture avatar
            Center(
              child: GestureDetector(
                onTap: () {
                  // Open gallery to select photo
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Name field
            buildTextField('Faculty Name', nameController),

            // Email field
            buildTextField('Email', emailController),

            // Contact Number field
            buildTextField('Contact Number', contactController),

            // Degree field
            buildTextField('Degree', degreeController),

            // Experience field
            buildTextField('Experience (in years)', experienceController),

            // Date of Birth field
            buildTextField('Date of Birth', dobController, hintText: 'dd/mm/yyyy'),

            // Date of Joining field
            buildTextField('Date of Joining', dateOfJoiningController, hintText: 'dd/mm/yyyy'),

            // Status (Currently Working or Not)
            SizedBox(height: 20),
            Text(
              'Status:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blueGrey),
            ),
            DropdownButtonFormField<String>(
              value: selectedStatus,
              items: ['Currently Working', 'Not Working'].map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedStatus = value;
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),

            // Address Section (bordered container)
            Text(
              'Address:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blueGrey),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  buildTextField('Address Line 1', addressLine1Controller),
                  buildTextField('Address Line 2', addressLine2Controller),
                  buildTextField('City', cityController),
                  buildTextField('State', stateController),
                  buildTextField('Country', countryController),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Submit button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle form submission
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget buildTextField(String label, TextEditingController controller, {String hintText = ''}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blueGrey,
            ),
          ),
          SizedBox(height: 5),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText.isNotEmpty ? hintText : label,
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    contactController.dispose();
    dobController.dispose();
    degreeController.dispose();
    experienceController.dispose();
    dateOfJoiningController.dispose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.dispose();
  }
}
