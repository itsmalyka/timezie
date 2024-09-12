import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timezie/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:timezie/services/taskProvider.dart';
import 'package:firebase_core/firebase_core.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(timezie());
}

class timezie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>taskProvider(),
      child:MaterialApp(
        /*theme: ThemeData(
          textTheme: TextTheme(
            bodyText2: TextStyle(fontFamily: 'OpenSans'),
            headline1: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
            bodyText1: TextStyle(fontFamily: 'OpenSans', fontStyle: FontStyle.italic),
          ),
        ),*/
        home: home_screen(),
      )

    );

  }
}

