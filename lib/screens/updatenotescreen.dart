import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:notes_app/screens/userscreen.dart';
import '../auth.dart';

class UpdateNoteScreen extends StatefulWidget {
  static const String id = "UpdateNoteScreen";

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  String titletext = Authorization.headline.toString();
  String desctext = Authorization.belowline.toString();
  String? uid;
  TextEditingController? _controller1;
  TextEditingController? _controller2;
  void initState() {
    uid = Authorization.uid;
    _controller1 =
        new TextEditingController(text: Authorization.headline.toString());
    _controller2 =
        new TextEditingController(text: Authorization.belowline.toString());
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
                controller: _controller1,
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
              controller: _controller2,
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
                heroTag: "btn2",
                backgroundColor: Colors.green.shade200,
                onPressed: () {
                  Authorization.updatenote(
                      titletext, desctext, uid, Authorization.idofdocument);
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.save,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              FloatingActionButton(
                heroTag: "btn1",
                backgroundColor: Colors.green.shade200,
                onPressed: () async {
                  await Authorization.deletenote(Authorization.idofdocument);
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.delete,
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
