import 'package:e_commerce_flutter/model/app_state.dart';
import 'package:e_commerce_flutter/model/product.dart';
import 'package:e_commerce_flutter/model/user.dart';

import 'actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: userReducer(state.user, action),
    products: productReducer(state.products,action),
    cartProducts: cartProductReducer(state.cartProducts,action),

  );
}

User userReducer(User user, dynamic action) {
  if (action is GetUserAction) {
    return action.user;
  }else if(action is LogOutUserAction){
    return action.user;

  }
  return user;
}
List<Product> productReducer( List<Product> products,dynamic action){

  if(action is GetProductAction){
    return action.products;
  }

  return products;

}
List<Product> cartProductReducer( List<Product> cartProducts,dynamic action){

  if(action is GetCartProductAction){
    return action.cartProducts;
  }
  else if(action is ToggleCartProductAction){
    return action.cartProducts;
  }
  return cartProducts;

}
