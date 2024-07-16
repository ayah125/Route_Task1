// cart_screen.dart
import 'package:c_route_task/bussiness_logih/Bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  String routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded) {
            if (state.cart.isEmpty) {
              return Center(child: Text('Your cart is empty'));
            }
            return ListView.builder(
              itemCount: state.cart.length,
              itemBuilder: (context, index) {
                final product = state.cart[index];
                return ListTile(
                  leading: Image.network(
                    product.thumbnail,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(product.title),
                  subtitle: Text(
                    'EGP ${product.price}',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      BlocProvider.of<ProductBloc>(context)
                          .add(RemoveFromCart(product));
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
