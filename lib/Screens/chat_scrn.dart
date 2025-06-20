import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ligthning_chat/Screens/ScrnsWidgets/MassegeBubble.dart';

class ChatScrn extends StatefulWidget {
  const ChatScrn({super.key});

  @override
  State<ChatScrn> createState() => _ChatScrnState();
}

class _ChatScrnState extends State<ChatScrn> {
  final TextEditingController massageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  dynamic loggedInUser;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    massageController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void massegeStream() {
    _firestore.collection("masseges").snapshots().listen((snapshot) {
      for (var doc in snapshot.docs) {
        print(doc.data());
      }
    });
  }

  timestamp() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Chat Screen',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                _auth.signOut().then((value) {
                  print("User Logged Out");
                  Navigator.pop(context);
                }).catchError((e) {
                  print(e);
                });
              },
            ),
          ],
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection("masseges")
                      .orderBy("timestamp",
                          descending:
                              true) // true for newest first, false for oldest first
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final messages = snapshot.data!.docs;
                    List<Widget> messageWidgets = [];
                    for (var message in messages) {
                      final messageText = message['text'];
                      final messageSender = message['sender'];
                      final messageTime = message[
                          'timestamp']; // Uncomment if you want to use timestamp
                      final messageWidget = ListTile(
                        title: Massegebubble(
                          sender: messageSender,
                          text: messageText,
                          time: messageTime,
                          isMe: loggedInUser.email == messageSender,
                        ),
                      );
                      messageWidgets.add(messageWidget);
                    }
                    return Expanded(
                      child: ListView(
                        reverse: true,
                        children: messageWidgets,
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: massageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal:
                                8.0, // Adds padding on the left and right
                            vertical:
                                12.0, // Adds padding on the top and bottom (adjust as needed)
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.blueAccent),
                      onPressed: () {
                        _firestore.collection("masseges").add({
                          'text': massageController.text,
                          'sender': loggedInUser.email,
                          'timestamp': timestamp(),
                        }).then((value) {
                          print("Message Sent");
                          massageController.clear();
                        }).catchError((e) {
                          print(e);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
