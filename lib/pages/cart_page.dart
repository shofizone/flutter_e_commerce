import 'package:e_commerce_flutter/model/app_state.dart';
import 'package:e_commerce_flutter/pages/home_page.dart';
import 'package:e_commerce_flutter/widgets/product_itme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
          labelColor:   Colors.white,
          unselectedLabelColor: Colors.deepOrange[200],

              tabs: [
            Tab(icon: Icon(Icons.shopping_cart),),
            Tab(icon: Icon(Icons.credit_card),),
            Tab(icon: Icon(Icons.receipt),),
          ]),
        ),
        body: TabBarView(children: <Widget>[
          _cartTab(),
          _creditCardTab(),
          _orderTab(),

        ]),
      ),
    );
  }

  _cartTab() {
    final orientation = MediaQuery
        .of(context)
        .orientation;
    return StoreConnector<AppState, AppState>(
      converter: (Store store) => store.state,
      builder: (BuildContext context, state) {
        return Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: SafeArea(
                    top: false,
                    bottom: false,
                    child: GridView.builder(
                        itemCount: state.cartProducts.length,
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
                          return ProductItem(state.cartProducts[index]);
                        })),
              ),
            ],
          ),
        );
      },
    );
  }
    _creditCardTab(){return Center(child: Text("_creditCardTab"),);}
    _orderTab(){return Center(child: Text("_orderTab"),);}

}

