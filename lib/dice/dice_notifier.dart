import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DiceNotifier extends ChangeNotifier {
  bool _isRolled = false;
  int _output = 1;

  get isRolled => _isRolled;
  get output => _output;
  set output(value) {
    _output = value;
  }

  rollDice() async {
    _isRolled = false;
    var rollCounter = 0;

    do {
      _generateOutputAndNotify();
      await Future.delayed(Duration(milliseconds: 100));
      rollCounter++;
    } while (rollCounter != 5);

    _isRolled = true;
    _generateOutputAndNotify();
    //send is rolled
    Firestore.instance
        .collection('dice_output')
        .document('HHTdexQBnXGdDVgQCTtN')
        .updateData({"is_rolled": _isRolled});
  }

  _generateOutputAndNotify() async {
    _output = 1 + Random().nextInt(6);
    //send dice output from here
    //
    Firestore.instance
        .collection('dice_output')
        .document('HHTdexQBnXGdDVgQCTtN')
        .updateData({"dice_output": _output});

    notifyListeners();
  }
}
