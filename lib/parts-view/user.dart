class User {
  final String lp;
  final String nameOfPart;
  final String partNumber;

  const User(
      {required this.lp, required this.nameOfPart, required this.partNumber});

  static User fromJson(json) => User(
      lp: json['lp'],
      nameOfPart: json['nameOfPart'],
      partNumber: json['partNumber']);
}
