import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit_foot_touching/google_ml_kit.dart';
import 'package:mobile_final/model/user_model.dart';
import 'camera_view.dart';
import 'painters/pose_painter.dart';





class PoseDetectorView_foot_touching extends StatefulWidget {
  final bool useClassifier;
  final bool isActivity;
  final int scoreSum;

  const PoseDetectorView_foot_touching({
    this.useClassifier = true,
    this.isActivity = true,
    this.scoreSum = 0,
  });

  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<PoseDetectorView_foot_touching> {
  PoseDetector poseDetector = GoogleMlKit.vision.poseDetector();
  bool isBusy = false;
  CustomPaint? customPaint;
  String poseName = "";
  double poseAccuracy = 0.0;
  int poseReps = 0;
  bool _running = true;
  int playTime = 0;
  UserModel? userModel; //! ตัวเราเอง
  String? uidMe; //! uid ของเรา
  String? uid; //! uid เรา

  @override
  void initState() {
    super.initState();
    findUid();
    // movePage();
    autoPlayTime();
  }

  Future findUid() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      uidMe = event!.uid;
      print('## uid = $uidMe');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uidMe)
          .get()
          .then((value) {
        setState(() {
          userModel = UserModel.fromMap(value.data()!);
        });
      });

      print('${userModel == null ? '## null' : '## ${userModel!.imageUrl}'}');
    });
  }

  Future<void> autoPlayTime() async {
    Duration duration = Duration(seconds: 1);
    // ignore: await_only_futures
    await Timer(duration, () {
      setState(() {
        playTime++;
      });
      autoPlayTime();
    });
  }

  // Future movePage() async {
  //   while (_running) {
  //     await Future<void>.delayed(const Duration(seconds: 1));
  //     if (playTime == 30) {
  //       _running = false;
  //       _running = false;

  //       int timeSum = playTime;
  //       int _sumScore = widget.scoreSum;
  //       poseReps *= timeSum;
  //       poseReps ~/= 30;
  //       _sumScore += poseReps;
  //       print("##############sum == $_sumScore  = $timeSum = $_sumScore  == poserep== $poseReps");

  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => PoseDetectorView_arm_stretch(
  //                     scoreSum: _sumScore,
  //                     timeInfo: playTime,
  //                   )));
  //     }
  //   }
  // }

  void dispose() async {
    super.dispose();
    await poseDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    // if (poseReps == 5) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Second Route'),
    //     ),
    //     body: Center(
    //       child: ElevatedButton(
    //         onPressed: () {
    //           Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) => const PoseDetectorView(
    //                                 useClassifier: true,
    //                                 isActivity: true,
    //                               )));
    //         },
    //         child: const Text('Go back!'),
    //       ),
    //     ),
    //   );

    // } else {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            CameraView(
              customPaint: customPaint,
              onImage: (inputImage) {
                processImage(
                  inputImage,
                  widget.useClassifier,
                  widget.isActivity,
                );
              },
            ),
            Text(
              "Squat",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            widget.useClassifier
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        '${poseReps == 0 ? '' : '($poseReps) '}$poseName: $poseAccuracy ==== $playTime',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 30,
                    width: 30,
                    color: Colors.red,
                  ),
          ],
        ),
      ),
    );
  }
  // }

  Future<void> processImage(
    InputImage inputImage,
    bool useClassifier,
    bool isActivity,
  ) async {
    if (isBusy) return;
    isBusy = true;
    final poses = await poseDetector.processImage(
      inputImage: inputImage,
      useClassifier: widget.useClassifier,
      isActivity: isActivity,
    );

    if (useClassifier) {
      poses.forEach((pose) {
        poseName = pose.name;
        poseAccuracy = pose.accuracy;
        poseReps = pose.reps;
      });
    }

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = PosePainter(
        poses,
        inputImage.inputImageData!.size,
        inputImage.inputImageData!.imageRotation,
      );
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }

    isBusy = false;

    if (mounted) {
      setState(() {});
    }
  }
}
