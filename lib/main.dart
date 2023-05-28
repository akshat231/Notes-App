import 'package:flutter/material.dart';

import './screens/loginscreen.dart';
import './screens/registerscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/notescreen.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import './screens/userscreen.dart';
import './screens/updatenotescreen.dart';

void main() 

  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyCN9S7iCM-uEo4pJO3wOYZ7B-jHEnVumYg", appId: "1:947863918813:android:19a986bfb515eb0044a334", messagingSenderId: "947863918813", projectId: "notes-app-1810b"),
  );
  FacebookAuth.instance.webAndDesktopInitialize(
        appId: "1970701713276558", cookie: false, xfbml: true, version: 'v2.7');
   runApp(notesapp());
  }
  



class notesapp extends StatelessWidget {
  const notesapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: LoginScreen.id,
      routes: {
        
        LoginScreen.id:(context) => LoginScreen(),
        RegisterScreen.id:(context) => RegisterScreen(),
        NoteScreen.id:(context) => NoteScreen(),
        UserScreen.id:(context) => UserScreen(),
        UpdateNoteScreen.id:(context) => UpdateNoteScreen(),
      },

    );
  }
}
