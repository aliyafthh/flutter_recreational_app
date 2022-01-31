import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {

  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this, //initialise ticker
      // upperBound: 100.0 // set max ticker for animation
    );
    // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate); //if ada ni upperBound = 1
    // controller.reverse(from:1);//big to small from specific starting point
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white,).animate(controller);//animate colour change
    controller.forward(); //small to big

    // controller.addStatusListener((status) { //tells u when the animation has ended
    //   //end of forward == completed
    //   //end of reverse == dismissed
    //   if(status == AnimationStatus.completed){
    //     controller.reverse(from: 1);
    //   }else if(status == AnimationStatus.dismissed){
    //     controller.forward();
    //   }
    // });

    controller.addListener(() {
      setState(() {
      });
    });


  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 60.0,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [TypewriterAnimatedText(
                    'Rekreasi',
                    textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                    speed: Duration(milliseconds: 500),
                  ),
                  ],

                  repeatForever: true,
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            buildPadding(Colors.lightBlueAccent,'Log In', () {
              Navigator.pushNamed(context, LoginScreen.id);}),

            buildPadding(Colors.blueAccent,'Register', () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            } ),
          ],
        ),
      ),
    );
  }

  Padding buildPadding(Color color, String stringText, void Function() onPress) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(stringText, style:TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}