import 'package:chat_app/chat/messages.dart';
import 'package:chat_app/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Screen"),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(children: <Widget>[
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Logout"),
                  ]),
                ),
                value: "logout",
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == "logout") {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMesssage()
          ],
        ),
      ),
      // body: StreamBuilder<QuerySnapshot>(
      //     stream: FirebaseFirestore.instance
      //         .collection("chats")
      //         .doc("47QwvEtG1rR2rjPPPWqt")
      //         .collection("messages")
      //         .snapshots(),
      //     builder: (context, streamSnapshot) {
      //       if (streamSnapshot.connectionState == ConnectionState.waiting) {
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //       final doc = streamSnapshot.data!.docs;
      //       return ListView.builder(
      //         itemCount: doc.length,
      //         itemBuilder: (ctx, index) => Container(
      //             padding: EdgeInsets.all(8),
      //             child: Text(doc[index]['text'])),
      //       );
      //     }),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //       FirebaseFirestore.instance
      //           .collection("chats/47QwvEtG1rR2rjPPPWqt/messages")
      //           .add({'text': "This is new message"});
      //     })
    );
  }
}
