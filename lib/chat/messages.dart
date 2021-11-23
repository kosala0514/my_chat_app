import 'dart:html';

import 'package:chat_app/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.value(FirebaseAuth.instance.currentUser),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("chat")
                .orderBy('created_at', descending: true)
                .snapshots(),
            builder: (cts, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final chatDocs = chatSnapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (ctx, index) => MessageBubble(
                    message: chatDocs[index]['text'],
                    isMe: chatDocs[index]['user_id'] ==
                        FirebaseAuth.instance.currentUser,
                    username: chatDocs[index]['username'],
                    key: ValueKey(
                      chatDocs[index].id,
                    ),
                  ),
                );
              }
            },
          );
        });
  }
}
