// product_grid.dart
import 'package:c_route_task/bussiness_logih/Bloc.dart';
import 'package:c_route_task/presentation/ProductCard.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ProductCard(product: product);
            },
          );
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        }
        return Center(child: Text('No products found'));
      },
    );
  }
}
