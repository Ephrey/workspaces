import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/utils/routes.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController textController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText;

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                await _auth.signOut();
                Navigator.of(context).pushNamed(Routes.login);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      controller: textController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      textController.clear();
                      CollectionReference messages =
                          _fireStore.collection('messages');

                      await messages.add(
                        {
                          'text': messageText,
                          'sender': loggedInUser.email,
                          'sendDate': new DateTime.now().toUtc(),
                        },
                      );
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _fireStore
          .collection('messages')
          .orderBy('sendDate', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData) {
          return Center(child: Text('Welcome to Flash Chat '));
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            children: snapshot.data.docs.map(
              (d) {
                final messageText = d.data()['text'];
                final messageSender = d.data()['sender'];
                return ChatBubble(
                  text: messageText,
                  sender: messageSender,
                  isMe: messageSender == loggedInUser.email,
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final String sender;
  final bool isMe;

  ChatBubble({this.text: '', this.sender, this.isMe});

  @override
  Widget build(BuildContext context) {
    final double topRight = isMe ? 0.0 : 20.0;
    final double topLeft = isMe ? 20.0 : 0.0;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 5.0),
          SizedBox(
            width: text.length > 50 ? 300.0 : null,
            child: Material(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(topLeft),
                bottomLeft: const Radius.circular(20.0),
                topRight: Radius.circular(topRight),
                bottomRight: const Radius.circular(20.0),
              ),
              elevation: 5.0,
              color: isMe ? Colors.lightBlueAccent : Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: isMe ? Colors.white : Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
