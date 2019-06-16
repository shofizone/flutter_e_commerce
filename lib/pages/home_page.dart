import 'package:e_commerce_flutter/model/app_state.dart';
import 'package:e_commerce_flutter/redux/actions.dart';
import 'package:e_commerce_flutter/widgets/product_itme.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'dart:convert';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:e_commerce_flutter/util/auth_helper.dart';
import 'package:badges/badges.dart';

final gradientBackground = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        stops: [
      0.1,
      0.3,
      0.5,
      0.7,
      0.9
    ],
        colors: [
      Colors.lightGreen[800],
      Colors.lightGreen[600],
      Colors.lightGreen[500],
      Colors.lightGreen[600],
      Colors.lightGreen[800],
    ]));

class HomePage extends StatefulWidget {
  final void Function() onInit;

  const HomePage({Key key, this.onInit}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  final _appBar = PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    child: StoreConnector<AppState, AppState>(
        builder: (context, state) {
          return AppBar(
            centerTitle: true,
            title: state.user != null
                ? Text(state.user.username)
                : InkWell(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    onTap: () => Navigator.pushNamed(context, "/login"),
                  ),
            leading: state.user != null
                ? Badge(
            badgeContent: Text("${state.cartProducts.length}"),
              position: BadgePosition(top: 3,right: 5),
              badgeColor: Colors.red,

              child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pushNamed(context, "/cart")),
            )
                : Text(""),
            actions: <Widget>[
              StoreConnector<AppState, VoidCallback>(
                converter: (store) {
                  return () => store.dispatch(logOutUserAction);
                },
                builder: (_, callBack) {
                  return state.user != null
                      ? IconButton(
                          icon: Icon(Icons.exit_to_app),
                          onPressed: callBack,
                        )
                      : Container();
                },
              ),
            ],
          );
        },
        converter: (Store store) => store.state),
  );

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return StoreConnector<AppState, AppState>(
      converter: (Store store) => store.state,
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: _appBar,
          body: Container(
            decoration: gradientBackground,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SafeArea(
                      top: false,
                      bottom: false,
                      child: GridView.builder(
                          itemCount: state.products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                orientation == Orientation.landscape ? 3 : 2,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 3,
                            childAspectRatio:
                                orientation == Orientation.landscape ? 1.4 : 1,
                          ),
                          itemBuilder: (_, index) {
                            return ProductItem(state.products[index]);
                          })),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
