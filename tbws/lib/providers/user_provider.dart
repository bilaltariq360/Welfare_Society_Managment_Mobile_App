import 'package:flutter/material.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User? userDetails;

  void setUserDetail(
      String userCNIC,
      String userName,
      String userMobile,
      String userStreet,
      String houseArea,
      String userHouseProperty,
      String userHouseNo,
      String password) {
    userDetails = User(
        userCNIC: userCNIC,
        userName: userName,
        userMobile: userMobile,
        userStreet: userStreet,
        houseArea: houseArea,
        userHouseProperty: userHouseProperty,
        userHouseNo: userHouseNo,
        password: password);
  }

  get getUserDetails {
    return userDetails!;
  }
}
