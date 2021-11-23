import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMesssage extends StatefulWidget {
  const NewMesssage({Key? key}) : super(key: key);

  @override
  _NewMesssageState createState() => _NewMesssageState();
}

class _NewMesssageState extends State<NewMesssage> {
  final _controller = TextEditingController();
  var _enterMessage = "";

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection("chat").add({
      'text': NewMesssage,
      'created_at': Timestamp.now(),
      'user_id': user.uid,
      'username': userData['username']
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'send message...'),
            onChanged: (value) {
              setState(() {
                _enterMessage = value;
              });
            },
          )),
          IconButton(
            onPressed: _enterMessage.trim().isEmpty ? null : _sendMessage,
            icon: const Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
