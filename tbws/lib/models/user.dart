enum HouseProperty { owner, rental }

class User {
  String userCNIC;
  String userName;
  String userMobile;
  String userStreet;
  String houseArea;
  HouseProperty userHouseProperty;
  String userHouseNo;
  String password;

  User(
      {required this.userCNIC,
      required this.userName,
      required this.userMobile,
      required this.userStreet,
      required this.houseArea,
      required this.userHouseProperty,
      required this.userHouseNo,
      required this.password});
}
