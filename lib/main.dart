import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfierebasedemo/Utilities.dart';
import 'googelsignin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  //while(true)
  {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
    } catch (e) {}
  }
  runApp(FirebaseDemo());
}

class FirebaseDemo extends StatefulWidget {
  @override
  _FirebaseDemoState createState() => _FirebaseDemoState();
}

class _FirebaseDemoState extends State<FirebaseDemo> {
  String username = "", chatmessage = "", status = "Messages";
  TextEditingController textcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    () async{
      Utilities.userdata = await VsjGoogleSignIn.getUser();
    };
    firebaseInit();
  }

  void firebaseInit() {
    try {} catch (ee) {
      print(ee);
    }
  }

  _FirebaseDemoState() {}
  String firebasedata = "data";

  //*****************************************************************************

  //*****************************************************************************

  String loginfo = "Pilikothi software side";
  dynamic data = Utilities.userdata;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.tealAccent,
        appBar: AppBar(
          title: Text(loginfo),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(loginfo),
              Text(data),
             // Text(Utilities.userdata),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await VsjGoogleSignIn.doSignIn();
                      User? user = VsjGoogleSignIn.getUser();
                      if (user == null) {
                        data = "Null";
                      } else {
                        data = user.displayName!;
                        initState();
                      }
                    } catch (ex) {
                      data = ex.toString();
                    }

                    setState(() {});
                  },
                  child: const Text("sign in")),

              ElevatedButton(
                  onPressed: () async {
                    try{
                      await VsjGoogleSignIn.doSignOut();
                      data="Success_fully sign out";
                    }catch (ex){
                      data=ex;
                    }

                    setState(() {
                    });
                  },
                  child: const Text("sign out")),
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
