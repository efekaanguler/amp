import 'package:amp/screens/login_screen.dart';
import 'package:amp/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Hero(
                          tag: 'logo',
                          child: Container(
                            child: Image.asset('images/logo.png'),
                            height: 80.0,
                          ),
                        ),
                        Text(
                          'Açık Mesajlaşma\nPlatformu',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      '\"Açıktan Açıktan Açıkça Mesajlaş İşte\"',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey.shade400),
                    ),
                  ],
                ),
              ),
              Hero(
                tag: 'login_button',
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.purple.shade400,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Log In',
                      ),
                    ),
                  ),
                ),
              ),
              Hero(
                tag: 'register_button',
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.purple.shade700,
                    borderRadius: BorderRadius.circular(30.0),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Register',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
