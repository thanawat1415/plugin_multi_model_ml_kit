import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit_1/google_ml_kit.dart';
import 'package:google_ml_kit_example/all_images/model.dart';
import 'camera_view.dart';
import 'painters/pose_painter.dart';

class PoseDetectorView1 extends StatefulWidget {
  final bool useClassifier;
  final bool isActivity;

  const PoseDetectorView1({
    this.useClassifier = true,
    this.isActivity = true,
  });

  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<PoseDetectorView1> {
  PoseDetector poseDetector = GoogleMlKit.vision.poseDetector();
  bool isBusy = false;
  CustomPaint? customPaint;
  String poseName = "";
  double poseAccuracy = 0.0;
  int poseReps = 0;
  bool _running = true;
  int playTime = 0;
  @override
  void initState() {
    super.initState();
    movePage();
    autoPlayTime();
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

  Future movePage() async {
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (playTime == 15) {
        _running = false;
        Navigator.pop(context);
      }
    }
  }

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
        child: Stack(
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
            widget.useClassifier
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        '${poseReps == 0 ? '' : '($poseReps) '}$poseName: $poseAccuracy ==== $playTime',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : Container(),
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
