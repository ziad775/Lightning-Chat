import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Massegebubble extends StatelessWidget {
  const Massegebubble(
      {super.key,
      required this.text,
      required this.sender,
      required this.time,
      required this.isMe});
  final String text;
  final String sender;
  final String time;
  final bool isMe; // This can be set based on the sender of the message
  // This widget is the bubble that displays a message with an avatar.
  // It includes the current time in the format "HH:MM".
  String get currentTime {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Display the sender's avatar and name
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMe) // Show avatar only for the sender
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      'https://www.w3schools.com/howto/img_avatar.png'), // Replace with actual image URL
                ),
              const SizedBox(width: 10),
              Text(
                isMe ? "Me" : sender,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: !isMe ? Colors.blueAccent : Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: !isMe ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
