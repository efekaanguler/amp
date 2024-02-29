import 'package:flutter/material.dart';
import 'package:amp/screens/welcome_screen.dart';
import 'package:amp/screens/login_screen.dart';
import 'package:amp/screens/registration_screen.dart';
import 'package:amp/screens/chat_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.shantellSans().fontFamily),
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
