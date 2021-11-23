import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.isMe,
      required this.message,
      required this.username})
      : super(key: key);

  final String message;
  final String username;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
              color: isMe ? Theme.of(context).accentColor : Colors.teal[600],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomRight:
                    isMe ? const Radius.circular(0) : const Radius.circular(12),
                bottomLeft:
                    isMe ? const Radius.circular(0) : const Radius.circular(12),
              ),
            ),
            width: 140,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 6,
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  username,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe ? Colors.black : Colors.purple),
                ),
                // FutureBuilder<DocumentSnapshot>(
                //     future: FirebaseFirestore.instance
                //         .collection('users')
                //         .doc(userid)
                //         .get(),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return const Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       }
                //       return Text(
                //         snapshot.data!['username'],
                //         style: const TextStyle(fontWeight: FontWeight.bold),
                //       );
                //     }),
                Text(
                  message,
                  style: TextStyle(color: isMe ? Colors.black : Colors.purple),
                  textAlign: isMe ? TextAlign.end : TextAlign.start,
                ),
              ],
            )),
      ],
    );
  }
}
