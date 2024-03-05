import 'package:amp/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  static const id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    email = FirebaseAuth.instance.currentUser!.email!;
    super.initState();
  }

  final messageTextConroller = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  String? messageText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.grey.shade400,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              }),
        ],
        title: Hero(
          tag: 'amplogo',
          child: SizedBox(
            height: 50,
            child: Image.asset('images/logo.png'),
          ),
        ),
        backgroundColor: Colors.purple.shade700,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: messageTextConroller,
                      obscureText: false,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.purple.shade400, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.purple.shade400, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type your message here...',
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    messageTextConroller.clear();
                    _firestore.collection('messages').add({
                      'text': messageText,
                      'sender': email,
                      'createdAt': DateTime.now().millisecondsSinceEpoch
                    });
                  },
                  child: Icon(
                    Icons.send,
                    color: Colors.purple.shade400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore.collection('messages').orderBy("createdAt").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = (snapshot.data as QuerySnapshot).docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: (email == messageSender) ? true : false,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageBubbles,
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.sender, required this.text, required this.isMe});
  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: "your text"));
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              isMe ? 'me' : '$sender',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 10.0,
              ),
            ),
            Material(
              borderRadius: BorderRadius.only(
                topLeft: isMe ? Radius.circular(30) : Radius.circular(0),
                topRight: isMe ? Radius.circular(0) : Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              elevation: 5.0,
              color: isMe ? Colors.purple.shade700 : Colors.grey.shade800,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  '$text',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
