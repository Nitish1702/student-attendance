import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedAvatar extends StatefulWidget {
  @override
  _AnimatedAvatarState createState() => _AnimatedAvatarState();
}

class _AnimatedAvatarState extends State<AnimatedAvatar> with TickerProviderStateMixin{
  bool _isAvatarVisible = false;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(-1.0, 0.0), // Start off-screen to the left
                end: Offset.zero, // Slide to the center
              ).animate(CurvedAnimation(
                curve: Curves.easeIn,
                parent: AnimationController(
                  vsync: this,
                  duration: Duration(milliseconds: 500),
                )..forward(),
              )),
              child: AnimatedOpacity(
                opacity: _isAvatarVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/Account.gif'),
                ),
              ),
            ),
            SizedBox(height: 20),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isAvatarVisible = !_isAvatarVisible;
                });
              },
              child: Icon(Icons.play_arrow),
            ),
          ],
        ),
    );
  }
}
