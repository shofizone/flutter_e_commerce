import 'package:e_commerce_flutter/model/app_state.dart';
import 'package:e_commerce_flutter/model/product.dart';
import 'package:e_commerce_flutter/pages/product_detail_page.dart';
import 'package:e_commerce_flutter/redux/actions.dart';
import 'package:e_commerce_flutter/util/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ProductItem extends StatelessWidget {



  _isInState(AppState state, String id){
    final List<Product> cartProducts = state.cartProducts;
    
    return cartProducts.indexWhere((cardProduct)=> cardProduct.id == id) >-1;

  }

  final  Product productItem;
  ProductItem(this.productItem);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsPage(productItem))),
      child: GridTile(
        child: Material(child: Hero(tag:productItem.picture.url ,child: Image.network(productItem.picture.url)),color: Colors.white,),
        footer: GridTileBar(
          backgroundColor: Color(0xbb000000),
          title: Text(productItem.name,style: TextStyle(fontSize: 15,),overflow: TextOverflow.ellipsis,maxLines: 2,),
          subtitle: Text("\$ ${productItem.price}",style: TextStyle(fontSize: 16),overflow: TextOverflow.ellipsis,maxLines: 1,),
          trailing: StoreConnector<AppState,AppState>(
            converter: (Store store) => store.state,
            builder: (BuildContext context,  state) {
              if(state.user != null ){
                return IconButton(icon: Icon(Icons.shopping_cart,color: _isInState(state,productItem.id)? Colors.orangeAccent:Colors.white,), onPressed: (){
                  StoreProvider.of<AppState>(context).dispatch(toggleCartProductAction(productItem));
                },color: Colors.white,);
              }else{return Container();}
            },)
        ),

      ),
    );
  }
}
