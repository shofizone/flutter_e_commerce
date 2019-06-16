
import 'package:e_commerce_flutter/model/app_state.dart';
import 'package:e_commerce_flutter/model/product.dart';
import 'package:e_commerce_flutter/model/user.dart';
import 'package:e_commerce_flutter/util/auth_helper.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
/* user actions */

ThunkAction<AppState> getUserAction = (Store<AppState> store) async{
final  pref = await SharedPreferences.getInstance();
final String storeUser = pref.getString('user');
final user = storeUser != null ? User.fromJson(json.decode(storeUser)) : null;

store.dispatch(GetUserAction(user));
};

class GetUserAction{
  final User _user;
  GetUserAction(this._user);
  User get user => this._user;
}


ThunkAction<AppState> logOutUserAction = (Store<AppState> store) async{
  final  pref = await SharedPreferences.getInstance();
 await pref.remove('user');
 User user;
 store.dispatch(LogOutUserAction(user));
};

class LogOutUserAction{
  final User _user;
  LogOutUserAction(this._user);
  User get user => this._user;
}
// Product Actions

ThunkAction<AppState> getProductAction = (Store<AppState> store) async{
    http.Response response =  await http.get("${AuthHelper.baseUrl}/products");
    final List<dynamic> data = json.decode(response.body);
    List<Product> prducts=[];
    data.forEach((productData){
      Product product = Product.fromJson(productData);
      prducts.add(product);
    });
    store.dispatch(GetProductAction(prducts));
};

class GetProductAction{
  final  List<Product> _products;
  GetProductAction(this._products);
  List<Product> get products => this._products;
}


//cart product actions

ThunkAction<AppState> toggleCartProductAction (Product cartProduct){

  return (Store<AppState> store)async{
    final List<Product> cartProducts = store.state.cartProducts;
    final User user = store.state.user;
    final int index = cartProducts.indexWhere((product)=>product.id == cartProduct.id);

    List<Product> updatedCartProducts = List.from(cartProducts);
    bool isInCart = index >-1 == true;
    if(isInCart){
      updatedCartProducts.removeAt(index);
    }else{
      updatedCartProducts.add(cartProduct);
    }

    List<String> cartProductsIds = updatedCartProducts.map((product)=>product.id).toList();
    await http.put("${AuthHelper.baseUrl}/carts/${user.cartId}",body: {
      'products': json.encode(cartProductsIds)
    },headers: {
      'Authorization': 'Bearer ${user.jwt}'

    }
    );
    store.dispatch(ToggleCartProductAction(updatedCartProducts));
  };
}

class ToggleCartProductAction {
  final List<Product> _cartProducts;
  List<Product> get cartProducts => _cartProducts;

  ToggleCartProductAction(this._cartProducts);

}


ThunkAction<AppState> getCartProductAction = (Store<AppState> store) async{

  final prefs = await SharedPreferences.getInstance();
  
  String storedUser = prefs.getString('user');
  if(storedUser == null){
    return;
  }
  final User user = User.fromJson(json.decode(storedUser));
  http.Response response =  await http.get("${AuthHelper.baseUrl}/carts/${user.cartId}",headers: {
    'Authorization': 'Bearer ${user.jwt}'
  });

  List<Product> cartProducts = [];
  final responseData = json.decode(response.body)['products'];
  print("{Get Cart Products $responseData");
  responseData.forEach((productData){
    final Product product = Product.fromJson(productData);
    cartProducts.add(product);
  });

  store.dispatch(GetCartProductAction(cartProducts));

};


class GetCartProductAction {
  final List<Product> _cartProducts;
  List<Product> get cartProducts => _cartProducts;

  GetCartProductAction(this._cartProducts);

}