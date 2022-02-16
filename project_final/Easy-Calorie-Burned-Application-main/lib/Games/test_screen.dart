import 'package:flutter/material.dart';
import 'games_model/9_plugin/path_plugin_9.dart';

class test_screen extends StatefulWidget {
  const test_screen({Key? key}) : super(key: key);

  @override
  _test_screenState createState() => _test_screenState();
}

class _test_screenState extends State<test_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test_screen'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    child: const Text('01 arm_strech_and_full'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PoseDetectorView_arm_strech_and_full(
                                      // useClassifier: true,
                                      // isActivity: true,
                                      )));
                    }),
                ElevatedButton(
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    child: const Text('02 foot_touching'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PoseDetectorView_foot_touching(
                                      // useClassifier: true,
                                      // isActivity: true,
                                      )));
                    }),
                ElevatedButton(
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    child: const Text('03 front_kicking'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PoseDetectorView_front_kicking(
                                      // useClassifier: true,
                                      // isActivity: true,
                                      )));
                    }),
                ElevatedButton(
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    child: const Text('04 arm_circles'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PoseDetectorView_arm_circles(
                                      // useClassifier: true,
                                      // isActivity: true,
                                      )));
                    }),
                ElevatedButton(
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    child: const Text('05 bend_side'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PoseDetectorView_bend_side(
                                      // useClassifier: true,
                                      // isActivity: true,
                                      )));
                    }),
                ElevatedButton(
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    child: const Text('06 elbow_plank'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PoseDetectorView_elbow_plank(
                                      // useClassifier: true,
                                      // isActivity: true,
                                      )));
                    }),
                ElevatedButton(
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    child: const Text('07 lunges_1'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PoseDetectorView_lunges_1(
                                      // useClassifier: true,
                                      // isActivity: true,
                                      )));
                    }),
                ElevatedButton(
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    child: const Text('08 squat'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PoseDetectorView_squat(
                                      // useClassifier: true,
                                      // isActivity: true,
                                      )));
                    }),
                ElevatedButton(
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    child: const Text('09 standing_twist'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PoseDetectorView_standing_twist(
                                      // useClassifier: true,
                                      // isActivity: true,
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
