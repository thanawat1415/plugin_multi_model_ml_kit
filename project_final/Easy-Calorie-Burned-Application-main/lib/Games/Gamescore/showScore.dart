// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/model/score_model.dart';
import 'package:mobile_final/model/user_model.dart';

class showScore extends StatefulWidget {
  const showScore({Key? key}) : super(key: key);

  @override
  _showScoreState createState() => _showScoreState();
}

class _showScoreState extends State<showScore> {
  String? uidMe, uid;
  UserModel? userModel;
  List<ScoreModel> scoreModel = [];
  int sumScore = 0, playTime = 0;

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

  Future findScore() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      uid = event!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('mildScore')
          .orderBy('playDate', descending: true)
          .limit(1)
          .get()
          .then((value) {
        for (var item in value.docs) {
          ScoreModel model = ScoreModel.fromMap(item.data());
          setState(() {
            scoreModel.add(model);
            sumScore = scoreModel[0].sumScore;
            playTime = scoreModel[0].playTime;
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    findUid();
    findScore();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: scoreModel == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
                child: Column(
                  children: [
                    Text(
                      'คะแนนรวม ${sumScore}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'เวลาเล่น ${playTime}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
