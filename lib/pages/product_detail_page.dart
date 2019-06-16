import 'package:e_commerce_flutter/model/app_state.dart';
import 'package:e_commerce_flutter/model/product.dart';
import 'package:e_commerce_flutter/redux/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'home_page.dart';
class ProductDetailsPage extends StatefulWidget {
  final Product item;



  const ProductDetailsPage(this.item);
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState(this.item);
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  Product item;
  final _scafholdKey = GlobalKey<ScaffoldState>();



  _ProductDetailsPageState(this.item);


  _isInState(AppState state, String id){
    final List<Product> cartProducts = state.cartProducts;

    return cartProducts.indexWhere((cardProduct)=> cardProduct.id == id) >-1;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafholdKey,
      appBar: AppBar(
        title: Text(item.name),
        centerTitle: true,
      ),
      body: Container(
        decoration: gradientBackground,
        child: ListView(
          children: <Widget>[
            Material(
              color: Colors.white,
              child: Container(
                height: 350,
                width: double.infinity,
                child: Hero(tag:item.picture.url ,child: Image.network(item.picture.url)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(item.name,style: TextStyle(fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12,2.0,12,15),
              child: Text("Price: \$${item.price}",style: Theme.of(context).textTheme.body1,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: StoreConnector<AppState,AppState>(
                converter: (Store store) => store.state,
                builder: (BuildContext context,  state) {
                  if(state.user != null ){
                    return IconButton(icon: Icon(Icons.shopping_cart,color: _isInState(state,item.id)? Colors.orangeAccent:Colors.white,), onPressed: (){
                      _showScankbar();
                      StoreProvider.of<AppState>(context).dispatch(toggleCartProductAction(item));
                    },color: Colors.white,);
                  }else{return Container();}
                },),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(item.description),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  _showScankbar(){

    final snackbar = SnackBar(duration: Duration(seconds: 2),content: Text('Cart Updated',style: TextStyle(color: Colors.green,)) ,);
    _scafholdKey.currentState.showSnackBar(snackbar);
  }
}
