class User {
  final String userCNIC;
  final String userName;
  final String userMobile;
  final String userStreet;
  final String houseArea;
  final String userHouseProperty;
  final String userHouseNo;
  final String password;
  final bool isAdmin;

  User(
      {required this.userCNIC,
      required this.userName,
      required this.userMobile,
      required this.userStreet,
      required this.houseArea,
      required this.userHouseProperty,
      required this.userHouseNo,
      required this.password,
      required this.isAdmin});
}
