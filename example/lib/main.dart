import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'all_images/model.dart';

List<CameraDescription> cameras = [];
// List<CameraDescription> _availableCameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // _availableCameras = await availableCameras();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}



class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google ML Kit Demo App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    child: const Text('test of bas'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PoseDetectorView1(
                                  // useClassifier: true,
                                  // isActivity: true,
                                  )));
                    }),
                ElevatedButton(
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    child: const Text('test of bas'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PoseDetectorView(
                                    useClassifier: true,
                                    isActivity: true,
                                  )));
                    }),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class CustomCard extends StatelessWidget {
//   final String _label;
//   final Widget _viewPage;
//   final bool featureCompleted;

//   const CustomCard(this._label, this._viewPage,
//       {this.featureCompleted = false});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       margin: EdgeInsets.only(bottom: 10),
//       child: ListTile(
//         tileColor: Theme.of(context).primaryColor,
//         title: Text(
//           _label,
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         onTap: () {
//           if (Platform.isIOS && !featureCompleted) {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: const Text(
//                     'This feature has not been implemented for iOS yet')));
//           } else
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => _viewPage));
//         },
//       ),
//     );
//   }
// }
