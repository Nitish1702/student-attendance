import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_attendance/resources/auth_methods.dart';
import 'package:student_attendance/screens/login_screen.dart';
import 'package:student_attendance/utils/animation.dart';
import 'package:student_attendance/utils/utils.dart';

import '../widgets/custom_textfield.dart';

void main() {
  runApp(SignupPage());
}

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SignupScreen(),
      ),
    );
  }
}

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _regnumController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextInputType _textInputType = TextInputType.emailAddress;
  Uint8List? _file;
  bool _showForm = false;

  @override
  void initState() {
    super.initState();
    // Start animation after a short delay
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _showForm = true;
      });
    });
  }
  void selectImage()async{
    Uint8List file=await pickImage(ImageSource.gallery);
    setState(() {
      _file=file;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ClipRect(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.greenAccent, Colors.blue],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedOpacity(
                    opacity: _showForm ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: _showForm ? null : 1,
                      child: Column(
                        children: [
                          Stack(
                            children: [const Card(
                              borderOnForeground: true,
                              elevation: 5,
                              child: Image(
                                image: AssetImage('assets/images/Account1.gif'),
                              ),
                            ),

                            ]
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            controller: _nameController,
                            label: 'Name',
                            inputType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            controller: _regnumController,
                            label: 'Registration number',
                            inputType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            controller: _emailController,
                            label: 'Email',
                            inputType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            controller: _passwordController,
                            label: 'Password',
                            inputType: TextInputType.visiblePassword,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async{
                              await AuthMethods().SignUp(
                                  name: _nameController.text,
                                  regno: _regnumController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text
                              );
                              // Handle signup logic
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text('Sign Up'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              // Navigate to login page
                            },
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                'Already have an account? Login',
                                style: TextStyle(color: Colors.white),
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
          ),
        ),
      ),
    );
  }
}
