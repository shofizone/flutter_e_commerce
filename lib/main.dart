import 'package:e_commerce_flutter/pages/cart_page.dart';
import 'package:e_commerce_flutter/pages/home_page.dart';
import 'package:e_commerce_flutter/pages/login_page.dart';
import 'package:e_commerce_flutter/pages/register_page.dart';
import 'package:e_commerce_flutter/redux/actions.dart';
import 'package:e_commerce_flutter/redux/reducer.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'model/app_state.dart';

void main() {

  final store = Store<AppState>(appReducer,initialState: AppState.initial(),middleware: [thunkMiddleware,LoggingMiddleware.printer()] );

  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp(this.store);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'E-Commerce ',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.green[800] ,
          accentColor: Colors.lime[600],
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0,fontWeight: FontWeight.bold),
              title: TextStyle(fontSize: 36.0,fontWeight: FontWeight.bold),
              body1: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
          ),
        ),

        routes: {
          '/':(BuildContext context)=> HomePage(
              onInit: (){
                //dispatch a action to grab user data
                StoreProvider.of<AppState>(context).dispatch(getUserAction);
                StoreProvider.of<AppState>(context).dispatch(getProductAction);
                StoreProvider.of<AppState>(context).dispatch(getCartProductAction);
              }
          ),
          '/login':(BuildContext context)=> LoginPage(),
          '/register':(BuildContext context)=> RegisterPage(),
          '/cart':(BuildContext context)=> CartPage(),

        },
      ),
    );
  }
}
