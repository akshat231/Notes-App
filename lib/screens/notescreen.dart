import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:notes_app/screens/userscreen.dart';
import '../auth.dart';

class NoteScreen extends StatefulWidget {
  static const String id = "NoteScreen";

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  String? desctext;
  String? titletext;
  String? uid;
  void initState() {
    uid = Authorization.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: TextField(
                onChanged: (value) {
                  titletext = value;
                },
                style: TextStyle(
                  fontFamily: 'Mogra',
                  fontSize: 60.0,
                ),
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontFamily: 'Mogra',
                    fontSize: 60.0,
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.white,
            thickness: 5.0,
          ),
          Expanded(
            flex: 7,
            child: TextField(
              onChanged: (value) {
                desctext = value;
              },
              maxLines: null,
              style: TextStyle(
                fontFamily: 'Mogra',
                fontSize: 30.0,
              ),
              decoration: InputDecoration(
                hintText: 'Description',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontFamily: 'Mogra',
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.green.shade200,
                onPressed: () {
                  if(titletext==null||desctext==null)
                  {
                    Authorization.handleError("Null Value", context);
                  }
                  else
                  {
                    Authorization.addff(titletext, desctext, uid);
                    Navigator.pop(context);
                  }
                },
                child: const Icon(
                  Icons.save,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
