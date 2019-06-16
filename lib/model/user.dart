import 'package:meta/meta.dart';

class User {
  String id;
  String username;
  String email;
  String jwt;
  int cartId;

  User(
      {@required this.id,
      @required this.username,
      @required this.email,
      @required this.cartId,
      @required this.jwt});

  factory User.fromJson(Map<String, dynamic> json) {
    print(json);
    return User(
      id: json['id'].toString(),
      username: json['username'],
      email: json['email'],
      jwt: json['jwt'],
      cartId: json['cart_id'],
    );
  }
}
