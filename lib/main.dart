import 'package:flutter/material.dart';
import 'package:amp/screens/welcome_screen.dart';
import 'package:amp/screens/login_screen.dart';
import 'package:amp/screens/registration_screen.dart';
import 'package:amp/screens/chat_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:amp/screens/firebase_data.dart';

void main() {
  runApp(App());
}

class Amp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.shantellSans().fontFamily,
        scaffoldBackgroundColor: Colors.grey.shade900,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}

class App extends StatelessWidget {
  FirebaseData firebasedata = FirebaseData();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: firebasedata.getapikey(),
          appId: firebasedata.getappid(),
          messagingSenderId: firebasedata.getmessagingsenderid(),
          projectId: firebasedata.getprojectid(),
        ),
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SizedBox();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Amp();
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey.shade900,
              color: Colors.purple.shade400,
            ),
          );
        }
      },
    );
  }
}
