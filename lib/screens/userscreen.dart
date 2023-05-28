import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/updatenotescreen.dart';
import '../auth.dart';
import './notescreen.dart';
import './loginscreen.dart';

class UserScreen extends StatefulWidget {
  static const String id = "UserScreen";

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String? name;
  String? im;
  String? uid;
  bool fb = false;
  bool gl = false;
  bool pa = false;
  var setofcolors = [Colors.blue, Colors.yellow, Colors.deepPurple, Colors.red];

  void update() {
    setState(() {});
  }

  void initState() {
    fb=false;
    gl=false;
    pa=false;
    name = Authorization.profileName;
    im = Authorization.profileImage;
    uid = Authorization.uid;
    print(name);
    Authorization.checklogin(Authorization.uid, context);
    if (Authorization.fb == true) {
      fb = true;
    }
    if (Authorization.gl == true) {
      gl = true;
    }
    if (Authorization.pa == true) {
      pa = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Authorization.handleError("Please Click on Logout to go back", context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Notes',
            style: TextStyle(
              fontFamily: 'Mogra',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green.shade200,
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NoteScreen()))
                .then((value) {
              setState(() {
                // refresh state
              });
            });
          },
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    Authorization.profileName.toString(),
                    style: TextStyle(
                      fontFamily: 'Mogra',
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Expanded(
                    // <-- SEE HERE
                    child: SizedBox.shrink(),
                  ),
                  FadeInImage(
                    image: NetworkImage(Authorization.profileImage.toString()),
                    placeholder: AssetImage('images/7611770.png'),
                    width: 60,
                    height: 60,
                  ),
                  Expanded(
                    // <-- SEE HERE
                    child: SizedBox.shrink(),
                  ),
                  InkWell(
                    onTap: () async {
                      if (fb == true) {
                        await Authorization.fbsignout(context);
                      }
                      if (gl == true) {
                        await Authorization.googlesignout(context);
                      } 
                      else {
                        await Authorization.emailpasswordsignout(context);
                      }
                    },
                    child: Text(
                      'LogOut',
                      style: TextStyle(
                        fontFamily: 'Mogra',
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              FutureBuilder<QuerySnapshot>(
                  future: Authorization.fetchDocument(uid!),
                  builder: (context, snapshotsub) {
                    if (snapshotsub.connectionState ==
                        ConnectionState.waiting) {
                     return Text('wait');
                    }
                    if (snapshotsub.hasError) {
                      return Text(
                        'Error has occured, Please Login Again',
                        style: TextStyle(fontFamily: 'Mogra', fontSize: 50),
                      );
                    }
                    if (snapshotsub.hasData == null) {
                      return Text(
                        'Could not find any data',
                        style: TextStyle(fontFamily: 'Mogra', fontSize: 50),
                      );
                    } else {
                      final docs = snapshotsub.data?.docs;
                      final data = docs!.asMap();
                      print(snapshotsub.data!.size);
                      return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshotsub.data!.size,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) => ListCard(
                                title: data[index]!['Title'],
                                desc: data[index]!['Description'],
                                docid: data[index]!.id,
                                col: setofcolors[index % 4],
                                callback: update,
                              ));
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ListCard extends StatefulWidget {
  String title;
  String desc;
  String docid;
  Color col;
  final callback;
  ListCard({
    required this.title,
    required this.desc,
    required this.docid,
    required this.col,
    required this.callback,
  }) {
    title = title;
    desc = desc;
    docid = docid;
    col = col;
  }

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Authorization.opennote(
            widget.title, widget.desc, context, widget.docid);
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => UpdateNoteScreen()))
            .then((value) {
          widget.callback();
        });
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.col,
        ),
        child: Column(
          children: [
            Text(
              widget.title,
              maxLines: 1,
              style: TextStyle(
                  fontFamily: 'Mogra',
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              widget.desc,
              maxLines: 5,
              style: TextStyle(
                  fontFamily: 'Mogra',
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
