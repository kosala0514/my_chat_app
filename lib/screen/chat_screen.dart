import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("chats")
                .doc("47QwvEtG1rR2rjPPPWqt")
                .collection("messages")
                .snapshots(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final doc = streamSnapshot.data!.docs;
              return ListView.builder(
                itemCount: doc.length,
                itemBuilder: (ctx, index) => Container(
                    padding: EdgeInsets.all(8),
                    child: Text(doc[index]['text'])),
              );
            }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              FirebaseFirestore.instance
                  .collection("chats/47QwvEtG1rR2rjPPPWqt/messages")
                  .add({'text': "This is new message"});
            }));
  }
}
