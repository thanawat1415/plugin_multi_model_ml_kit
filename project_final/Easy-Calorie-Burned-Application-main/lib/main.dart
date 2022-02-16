import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_final/Games/exam_screen.dart';
import 'package:mobile_final/Games/mild_screen.dart';
import 'package:mobile_final/Games/moderate_screen.dart';
import 'package:mobile_final/Games/test_screen.dart';
import 'package:mobile_final/main_screen.dart';
import 'package:mobile_final/screens/Friend/acfriend.dart';
import 'package:mobile_final/screens/Friend/addfriend_screen.dart';
import 'package:mobile_final/screens/edituser_screen.dart';
import 'package:mobile_final/screens/Friend/friends_screen.dart';
import 'package:mobile_final/screens/home_screen.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mobile_final/screens/profile_screen.dart';
import 'package:camera/camera.dart';
import 'Auth/login_screen.dart';





import 'Games/exam_screen.dart';
import 'Games/games_model/02_mild/03_arm_circles/pose_detector_views_arm_circles.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final storage = new FlutterSecureStorage();

  Future<bool> checkLoginStatus() async{
    String? value = await storage.read(key: "uid");
    if(value == null){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for Errors
          if (snapshot.hasError) {
            print("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: FutureBuilder(
              future: checkLoginStatus(),
              builder: 
              (BuildContext context,AsyncSnapshot<bool>snapshot){
                if (snapshot.data == false){
                  return Login();
                }
                if (snapshot.connectionState == ConnectionState.waiting){
                  return Container(
                    color: Colors.white,
                    child: CircularProgressIndicator()
                  );
                }
                return MainScreen();
                // return PoseDetectorView_arm_circles();/
                
              }
            ),
          );
        });
  }
}

