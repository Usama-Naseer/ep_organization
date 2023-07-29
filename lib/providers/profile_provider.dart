import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/ep_user_model.dart';

class ProfileProvider extends ChangeNotifier {
  int selectedIndex = 0;
  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  EPUser? user;

  void setUser(EPUser? user) {
    this.user = user;
    notifyListeners();
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    user = null;
    notifyListeners();
  }
}
