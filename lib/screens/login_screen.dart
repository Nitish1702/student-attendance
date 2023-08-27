import 'package:flutter/material.dart';
import 'package:student_attendance/resources/auth_methods.dart';
import 'package:student_attendance/screens/dashboard.dart';
import 'package:student_attendance/utils/utils.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextInputType _textInputType = TextInputType.emailAddress;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ClipRect(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
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
                          const Card(
                            elevation: 5,
                            child: Image(
                              image: AssetImage('assets/images/attendance.jpg'),
                            ),
                          ),
                          SizedBox(height: 20),
                          Card(
                            elevation: 5, // Add elevation to the Card
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                contentPadding:
                                    EdgeInsets.all(12), // Adjust padding
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Card(
                            elevation: 5, // Add elevation to the Card
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                contentPadding:
                                    EdgeInsets.all(12), // Adjust padding
                              ),
                              obscureText: true,
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: ()async {
                              // Handle login logic
                              String login=await AuthMethods().LogIn(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  context: context);
                              if(login=='success') {
                                showSnackbar(context, 'Login Successful');

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        StudentDashboardPage(),
                                  ),
                                );
                              }
                              else showSnackbar(context, 'Wrong Credentials');
                            },
                            child: Text('Login'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              // Navigate to registration page
                            },
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                'Don\'t have an account? Sign up',
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
