import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:timezie/screens/login.dart';
import 'package:timezie/screens/taskscreen.dart';

class signup2 extends StatefulWidget {
  @override
  _signup2State createState() => _signup2State();
}

class _signup2State extends State<signup2> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _age = '';
  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/info.jpg'), // Replace with your image path
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {
                    Navigator.pop(context);
                  }),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
              decoration: BoxDecoration(
                color: Color(0xFF967BB6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Tell Us About Yourself',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('What should we call you?', style: TextStyle(fontSize: 18, color: Color(0xFF2E1A47))),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Your name',
                        filled: true,
                        fillColor: Color(0xFFf3dbfd),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _name = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text('What\'s your age?', style: TextStyle(fontSize: 18, color: Color(0xFF2E1A47))),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Your age',
                        filled: true,
                        fillColor: Color(0xFFf3dbfd),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _age = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text('Upload a profile picture', style: TextStyle(fontSize: 18, color: Color(0xFF2E1A47))),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color(0xFFf3dbfd),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _profileImage != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _profileImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Icon(
                          Icons.camera_alt,
                          color: Color(0xFF2E1A47),
                          size: 50,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => taskscreen()),
                            );
                            // Add your onPressed code here!
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                          primary: Color(0xFF2E1A47), // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Proceed',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => login()),
                          );
                        },
                        child: Text(
                          'Already have an account? Log In',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


