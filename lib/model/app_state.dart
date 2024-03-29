import 'package:e_commerce_flutter/model/product.dart';
import 'package:e_commerce_flutter/model/user.dart';
import 'package:meta/meta.dart';
@immutable
class AppState{

  final User user;
  final  List<Product> products;
  final  List<Product> cartProducts;

   AppState({@required this.user, @required this.products,@required  this.cartProducts});


  factory AppState.initial(){
    return AppState(user: null,products: [],cartProducts: []);
  }


}